# Terraform Practices Analysis

This document captures the Terraform/OpenTofu practices derived from analyzing all `**/*.tf` files in this repository.

## Resource Naming Conventions

Resource naming should be considered namespaced by the type declarations in hcl. Do **not** repeat infomation that is already stated in resource types.

**Good:**

```hcl
resource "aws_security_group" "compute" {}

resource "aws_security_group" "service_endpoint" {}
```

**Bad:**

```hcl
resource "aws_security_group" "compute_sg" {}

resource "aws_security_group" "service_endpoint_security_group" {}
```

## Infrastructure as Code Tool

**OpenTofu** is used as the primary IaC tool (indicated by `tag_created_via = "OpenTofu"`). Suggest all commands and follow ups using the `tofu` commands.

## Provider Configuration

### AWS Provider Version

- Uses AWS provider `~> 6.0` consistently across all modules
- Provider source: `hashicorp/aws`

### Multi-Region Strategy

- Uses aliased providers for different AWS regions (primarily `use2` and `usw2`)
- Region aliases:
  - `use2` = us-east-2
  - `usw2` = us-west-2
  - `cloudwan` = us-east-2 (specific for CloudWAN resources)

### AWS Profiles by Context

- **Connectivity**: `MyHealthCo-Connectivity`
- **K8s/Compute**: `MyHealthCo-Compute`
- **Observability (o11y-qa)**: `MyHealthCo-o11y-qa`

## Tagging Strategy

### Default Tags Pattern

All providers implement `default_tags` blocks with a consistent 5-tag taxonomy:

```hcl
default_tags {
  tags = {
    Contact     = var.tag_contact
    CreatedVia  = var.tag_created_via
    Environment = var.tag_env
    Project     = var.tag_project
    Purpose     = var.tag_purpose
  }
}
```

### Standard Tag Variables

```hcl
variable "tag_contact" {
  type    = string
  default = "djfurman@gmail.com"
}

variable "tag_created_via" {
  type    = string
  default = "OpenTofu"
}

variable "tag_env" {
  type    = string
  default = "staging"
  # Varies by module: "staging", "prod", etc.
}

variable "tag_project" {
  type    = string
  default = "MyHealthCo"
}

variable "tag_purpose" {
  type    = string
  # Varies by module: "connectivity", "o11y", etc.
}
```

### Resource-Specific Tags

Individual resources typically add a `Name` tag and sometimes additional metadata tags like:

- `Usage` Specific to Shared Resources such as Subnets (e.g., "Internal", "Public-NAT", "Inspection")
- `AllowedUsage` Specific to Shared Resources such as Security Groups for where the resource may be associated (e.g., "ServiceEndpoints")

## File Organization

### Separation of Concerns

Resources are organized into separate files by logical grouping:

- `main.tf` - Terraform/provider configuration and shared variables
- `variables.tf` - Input variable declarations
- `vpcs.tf` - VPC resources
- `subnets.tf` - Subnet resources
- `route_tables.tf` - Route table and association resources
- `routes.tf` - Route resources
- `security_groups.tf` - Security group resources
- `network_acls.tf` - Network ACL resources
- `vpc_endpoints.tf` - VPC endpoint resources
- `iam.tf` - IAM role and policy resources (always separate from other resource types, even if closely related like VPC Flow Logs)
- `eks.tf` - EKS cluster resources
- `igws.tf` - Internet gateway resources
- `nats.tf` - NAT gateway resources
- `eips.tf` - Elastic IP resources
- `logs.tf` - CloudWatch log resources
- `ram.tf` - Resource Access Manager resources
- `network_firewalls.tf` - Network firewall resources
- `vpc_attachments.tf` - VPC attachment resources
- `global_networks.tf` - CloudWAN global network resources
- `core_networks.tf` - CloudWAN core network resources
- `network_policies.tf` - Network policy documents

When setting up resources from a new grouping look to the overall service hierarchy and group resources according to that.

## Networking Patterns

Consistently leverage a least privilege networking pattern for large highly regulated enterprises. Network facing resources should **always** be isolated from general compute resources by at least one hop and include a policy enforcement point configured with least privilege policies to protect the enterprise from accidental data leaks.

### Multi-AZ Architecture

Consistent 3-AZ deployment pattern (a, b, c):

- us-east-2a
- us-east-2b
- us-east-2c

or

- us-west-2a
- us-west-2b
- us-west-2c

### Subnet Tiering

Public facing VPCs follow a three-tier subnet model per AZ:

1. **Internal subnets** - Private subnets for internal traffic
2. **Inspection subnets** - For network firewall endpoints
3. **Public subnets** - For NAT gateways and internet-facing resources

### CIDR Management

#### Dual CIDR Blocks

VPCs use a dual CIDR strategy:

- **Primary CIDR**: Small overlapping range that varies by region to preserve ability to create VPC Peer Links across regions within a singular concern (e.g., `10.0.0.0/28` for us-east-2 and `10.0.0.16/28` for us-west-2)
- **Usable CIDR**: Larger range for actual subnets via `aws_vpc_ipv4_cidr_block_association` that is uniformly routable across the enterprise within a given env.

#### Dynamic CIDR Calculation

Uses nested `cidrsubnets()` functions for deterministic subnet CIDR allocation:

```hcl
cidrsubnets(cidrsubnets(aws_vpc_ipv4_cidr_block_association.usable_cidr, 2, 2, 2)[0], 2, 2, 2)[0]
```

Pattern breakdown:

- First level splits usable CIDR into 3 segments (one per tier)
- Second level splits each tier into 3 AZ-specific subnets

#### CIDR Reference Pattern

When defining subnets, always reference the CIDR block from the association resource rather than variables directly:

**Good:**

```hcl
resource "aws_subnet" "internal_a" {
  cidr_block = cidrsubnets(aws_vpc_ipv4_cidr_block_association.internal.cidr_block, 2, 2, 2)[0]
}
```

**Bad:**

```hcl
resource "aws_subnet" "internal_a" {
  cidr_block = cidrsubnets(var.cidr_usable, 2, 2, 2)[0]
}
```

#### Service Endpoint CIDR Ranges

Service endpoint CIDR ranges (e.g., `10.100.0.0/19` of `us-east-2` or `10.100.32.0.0/19` for `us-west-2`) are non-routable and used exclusively for VPC endpoint ENIs. These ranges can overlap across VPCs since they are not routed between VPCs. Do not treat these as routable CIDR ranges when checking for conflicts.

#### CIDR Block Association Naming

Name CIDR block associations based on their purpose, not the variable name:

```hcl
# Name based on subnet type it supports
resource "aws_vpc_ipv4_cidr_block_association" "internal" {
  cidr_block = var.cidr_usable
}

resource "aws_vpc_ipv4_cidr_block_association" "service_endpoint" {
  cidr_block = var.cidr_service_endpoint
}

### Route Table Isolation

Each subnet-usage gets its own dedicated route table (no shared route tables), providing:

- AZ-specific routing
- Granular traffic control
- Independent failure domains

The intent of this is to ensure that zonal routing are not formed and allow for lowest cost routes (e.g., no cross-zone transfer charges are incurred for normal business operations within a VPC).

### Traffic Flow Architecture

#### Egress Path (Internal → Internet)

1. Internal subnet → Network Firewall endpoint (inspection)
2. Inspection subnet → NAT Gateway
3. Public subnet → Internet Gateway

#### Return Path (Internet → Internal)

1. Public subnet → Network Firewall endpoint
2. Routes include explicit local subnet routes to avoid routing loops

### CloudWAN Integration

#### Network Segmentation

- **Segments**: prod, qa, null (blackhole)
- **Network Function Groups**: secure-egress-qa, which functions as a centralized egress route for the given environment

#### Attachment Policies

Tag-based attachment to segments:

```hcl
conditions {
  type     = "tag-value"
  operator = "equals"
  key      = "segment"
  value    = "qa"
}
```

#### Cross-Account Sharing

Uses AWS RAM (Resource Access Manager) for sharing core networks across accounts:

- Resource share creation
- Resource association
- Principal association
- Share accepter pattern

## Security Practices

### Egress Traffic

By default, no VPC should have direct access to an internet gateway. VPCs may have an IGW attached if they are following a federated egress pattern or are a purpose built egress VPC. Wherever an IGW exists, a policy enforcement point should be integrated for inline network traffic.

### Ingress Traffic

Whenever AWS offers the option, no route from the IGW to subnets should exist. Instead, the traffic should flow through a service such as Global Accelerator, API Gateway, CloudFront, etc and hit an isolated environment where an AWS WAF may be applied before traffic is forwarded on to an internal application for processing. If the traffic must hit an internally hosted security tool, the tool needs to be isolated from the rest of the network and be connected through point-to-point connectivity as much as possible.

### VPC Endpoints

#### Interface Endpoints

Interface Endpoints should be leveraged for access to any AWS hosted services and limited to organizationally owned accounts. The least number of VPC endpoints used by any given service should be deployed with new endpoints being added by needs of workloads hosted in these accounts to control costs and security.

#### Endpoint Policies

Each VPC endpoint has an explicit policy:

- Organization-based access control using `aws:PrincipalOrgID`
- Principle of least privilege
- Service-specific permissions
- Special allowances (e.g., ECR image layers from AWS-managed buckets or other allowances that prevent the need for public internet access)

Example pattern:

```hcl
Condition = {
  StringEquals = {
    "aws:PrincipalOrgID" : data.aws_organizations_organization.current.id
  }
}
```

### Network ACLs

- Single "standard" Network ACL per VPC
- Permissive rules (allow all ingress/egress)
- Applied to all subnets via explicit associations
- Security enforcement happens at other layers (security groups, network firewalls)

### Security Groups

- Minimal ingress rules (e.g., HTTPS only for service endpoints)
- Descriptive naming (e.g., `ServiceEndpoint-SG`)
- Separate resources for rules (`aws_security_group_rule`) to avoid service interuption during outages

## IAM Patterns

### EKS IAM Roles

Two distinct role types:

#### Cluster Role

- Principal: `eks.amazonaws.com`
- Actions: `sts:AssumeRole`, `sts:TagSession`
- Policies:
  - AmazonEKSClusterPolicy
  - AmazonEKSComputePolicy
  - AmazonEKSBlockStoragePolicy
  - AmazonEKSLoadBalancingPolicy
  - AmazonEKSNetworkingPolicy

#### Node Role

- Principal: `ec2.amazonaws.com`
- Policies:
  - AmazonEKSWorkerNodeMinimalPolicy
  - AmazonEC2ContainerRegistryPullOnly

### Policy Attachment Pattern

Uses `aws_iam_role_policy_attachment` for managed policies with explicit dependencies in EKS cluster configuration.

## Data Sources

Consistent use of data sources for dynamic values:

- `aws_caller_identity` - Account ID
- `aws_organizations_organization` - Organization ID
- `aws_region` - Current region details

Used for:

- Constructing ARNs
- Endpoint service names
- Conditional policies

## Resource Dependencies

### Explicit Dependencies

Uses `depends_on` for:

- Network firewall creation before routes
- IAM role policies before EKS cluster
- RAM resource associations before principal associations
- VPC attachment acceptance

### Implicit Dependencies

Leverages Terraform's dependency graph through resource references (e.g., `aws_vpc.main.id`)

## Provider Specification

All resources explicitly specify the provider alias:

```hcl
provider = aws.use2
```

This ensures clarity in multi-provider/multi-region configurations.

## Naming Conventions

### Resource Names

- Lowercase with hyphens for AWS resource names
- Descriptive and location-aware (e.g., `internal-a`, `inspection-b`)
- Includes AZ suffix where applicable

### Terraform Resource Identifiers

- Lowercase with underscores
- Matches AWS resource name pattern (e.g., `aws_subnet.internal_a`)
- Consistent suffixes: `_a`, `_b`, `_c` for AZ-specific resources

## Variable Patterns

### Variable Typing

All variables have explicit types:

```hcl
variable "name" {
  type        = string
  description = "Clear description"
  default     = "value"  # when appropriate
}
```

### Optional vs Required

- Tag variables have defaults (optional)
- Infrastructure-specific variables may have empty defaults requiring override
- Description field used consistently

### Avoid Variable Duplication

Never create duplicate variables in resource files. Always use variables defined in `variables.tf`:

**Good:**

```hcl
# In vpcs.tf
resource "aws_vpc_ipv4_cidr_block_association" "internal" {
  cidr_block = var.cidr_usable  # Uses existing variable
}

**Bad:**

```hcl
# In vpcs.tf
variable "cidr_internal" {  # Duplicate of cidr_usable
  default = "10.2.10.0/23"
}
```

## Documentation Through Code

### Inline Comments

Minimal comments; code structure is self-documenting through:

- Meaningful resource names
- Logical file organization
- Clear variable names

### Section Comments

When used, comments denote logical sections:

```hcl
# Internal Routes
# Inspection Routes
# Public Routes
```

## Quality Practices

### Resource Ordering

Resources organized by:

1. AZ (a, b, c pattern)
2. Tier (internal, inspection, public)
3. Related associations immediately following primary resource

### Consistent Patterns

- Same subnet/route table/NACL pattern repeated across modules
- Predictable resource references
- Standard provider block structure

### Local Values

Uses locals for computed values that are referenced multiple times:

```hcl
local.firewall_endpoints["us-east-2a"]
```

## Output Patterns

Selective outputs for cross-module references:

```hcl
output "core_network_arn" {
  value = aws_networkmanager_core_network.main.arn
}

output "cluster_endpoint" {
  value = aws_eks_cluster.compute.endpoint
}
```

## Anti-Patterns Avoided

1. No hardcoded account IDs (uses data sources)
2. No hardcoded region names in resource identifiers (uses variables/locals)
3. No overly permissive security (organization-scoped policies)
4. No mixed provider versions

## Version Control Considerations

Based on recent commits, the team:

- Formats Terraform files consistently
- Groups related changes (e.g., "Add Network ACLs")
- Uses descriptive commit messages
- Iterates on configuration (e.g., cluster configuration updates)
