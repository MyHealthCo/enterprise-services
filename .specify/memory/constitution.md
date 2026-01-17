<!--
SYNC IMPACT REPORT
==================
Version change: N/A (initial) → 1.0.0
Bump rationale: Initial adoption of constitution - MAJOR version 1.0.0

Modified principles: N/A (initial creation)

Added sections:
- Core Principles (4 principles)
  - I. Infrastructure Code Clarity
  - II. Realistic Testing Scenarios
  - III. Operator Experience Consistency
  - IV. Performance & Cost Efficiency
- Security & Compliance Standards
- Development Workflow
- Governance

Removed sections: N/A (initial creation)

Templates requiring updates:
- .specify/templates/plan-template.md: ✅ Compatible (Constitution Check section exists)
- .specify/templates/spec-template.md: ✅ Compatible (Success Criteria aligns with performance principle)
- .specify/templates/tasks-template.md: ✅ Compatible (Phase structure supports testing discipline)

Deferred items: None
-->

# MyHealthCo Enterprise Services Constitution

## Core Principles

### I. Infrastructure Code Clarity

Every OpenTofu/Terraform configuration MUST be self-documenting through structure and naming.

- **File Organization**: Resources MUST be organized into separate files by logical AWS service grouping (e.g., `vpcs.tf`, `subnets.tf`, `iam.tf`). IAM resources MUST always reside in dedicated `iam.tf` files, never mixed with related resources.
- **Resource Naming**: Terraform resource identifiers MUST use lowercase with underscores and MUST NOT repeat type information (e.g., `aws_security_group.compute` not `aws_security_group.compute_sg`).
- **Variable Discipline**: All variables MUST have explicit types and descriptions. Variables MUST be defined only in `variables.tf`—never duplicated in resource files.
- **Provider Explicitness**: All resources in multi-region configurations MUST explicitly specify provider aliases (e.g., `provider = aws.use2`).
- **CIDR References**: Subnet definitions MUST reference CIDR blocks from `aws_vpc_ipv4_cidr_block_association` resources, not directly from variables.

**Rationale**: Clear, predictable code structure reduces cognitive load during incident response and enables safe autonomous changes by both humans and AI agents.

### II. Realistic Testing Scenarios

All infrastructure changes MUST be validated against scenarios that reflect actual operational conditions.

- **Plan Validation**: Every change MUST pass `tofu plan && tofu validate` with no unexpected resource recreations before merge nor any abnormal exit codes. Destructive changes MUST be explicitly acknowledged in PR descriptions.
- **State Verification**: After apply, infrastructure state MUST be verified against expected outcomes. Use `tofu show` or AWS CLI to confirm resource attributes match intent.
- **Multi-AZ Testing**: Changes affecting networking or compute MUST be validated across all three AZs (a, b, c) to prevent zonal routing failures.
- **Dependency Graph Verification**: Changes to shared resources (VPCs, subnets, security groups) MUST include verification that dependent resources are not inadvertently affected.
- **Rollback Validation**: For changes to stateful resources, document the rollback procedure and verify it is executable before applying to production.

**Rationale**: Infrastructure failures cascade quickly. Testing against realistic multi-AZ, multi-account scenarios prevents outages that would impact healthcare operations.

### III. Operator Experience Consistency

Infrastructure MUST provide a predictable, uniform experience for operators across all environments and regions.

- **Tagging Uniformity**: All resources MUST implement the 5-tag taxonomy via provider `default_tags`: Contact, CreatedVia, Environment, Project, Purpose. Resource-specific tags (Name, Usage, AllowedUsage) MUST follow documented conventions.
- **Region Parity**: Infrastructure patterns MUST be identical across us-east-2 and us-west-2 except for region-specific values (CIDRs, AZ names). Operators MUST be able to apply knowledge from one region to another.
- **Naming Predictability**: AWS resource names MUST follow the pattern `{purpose}-{az-suffix}` (e.g., `internal-a`, `inspection-b`). Operators MUST be able to infer resource purpose and location from names alone.
- **Output Consistency**: Module outputs MUST expose only what downstream modules require. Output names MUST be descriptive and consistent across modules (e.g., `cluster_endpoint`, `core_network_arn`).
- **Error Messaging**: Custom validation rules SHOULD provide actionable error messages that guide operators to resolution.

**Rationale**: Consistency reduces operator error during incidents and enables faster onboarding. Predictable patterns allow operators to act confidently under pressure.

### IV. Performance & Cost Efficiency

Infrastructure MUST be designed for optimal performance within cost constraints.

- **Route Table Isolation**: When leveraging AWS resources that are not regionally aware, each subnet MUST have its own dedicated route table to prevent cross-AZ traffic charges and enable AZ-specific routing control.
- **Endpoint Minimization**: VPC endpoints MUST be deployed based on workload requirements—not speculatively. Each endpoint incurs hourly cost and MUST justify its existence.
- **CIDR Efficiency**: Subnet CIDR allocations MUST use `cidrsubnets()` for deterministic, space-efficient allocation. Service endpoint CIDRs are non-routable and MAY overlap across VPCs.
- **Dependency Optimization**: Use implicit dependencies via resource references where possible. Use explicit `depends_on` only when Terraform cannot infer the dependency (e.g., IAM policies before EKS clusters).
- **Data Source Usage**: Dynamic values (account ID, organization ID, region) MUST be retrieved via data sources—never hardcoded. This prevents drift and enables multi-account reuse.

**Rationale**: Healthcare infrastructure must be cost-effective while maintaining high availability. Inefficient routing or unnecessary resources directly impact operational budgets.

## Security & Compliance Standards

Infrastructure MUST implement defense-in-depth for healthcare data protection.

- **Network Isolation**: Network-facing resources MUST be isolated from compute by at least one hop with a policy enforcement point (Network Firewall, WAF) in the path.
- **Egress Control**: No VPC SHOULD have direct IGW access. Egress MUST flow through inspection subnets with Network Firewall endpoints.
- **Ingress Control**: Public traffic MUST enter through managed services (CloudFront, API Gateway, Global Accelerator, Transfer Family) with WAF enforcement where applicable before reaching internal resources.
- **Endpoint Policies**: All VPC endpoints MUST have explicit policies scoped to `aws:PrincipalOrgID`. No internal endpoint may permit access outside the organization.
- **Least Privilege**: IAM roles MUST use minimal required policies. EKS node roles MUST use `AmazonEKSWorkerNodeMinimalPolicy`, not broader alternatives.

## Development Workflow

All infrastructure changes MUST follow this workflow.

1. **Branch**: Create feature branch following `features/{description}` pattern.
2. **Plan**: Run `tofu plan` and review all changes. Document any resource recreations.
3. **Validate**: Verify changes comply with Constitution principles (code clarity, testing, consistency, performance).
4. **Review**: PR requires review verifying compliance with Security & Compliance Standards.
5. **Apply**: Apply to staging first. Verify state matches expectations before production.
6. **Document**: Update CLAUDE.md if changes introduce new patterns or conventions.

## Governance

This Constitution supersedes all other infrastructure practices for MyHealthCo Enterprise Services.

- **Amendment Process**: Changes to this Constitution require documented rationale, team review, and migration plan for existing infrastructure.
- **Version Policy**: Constitution follows semantic versioning. MAJOR for principle changes, MINOR for new guidance, PATCH for clarifications.
- **Compliance Review**: All PRs MUST verify compliance with Core Principles. Reviewers MUST reject changes that violate principles without documented justification in the Complexity Tracking table.
- **Guidance Reference**: See `CLAUDE.md` for detailed implementation patterns and examples derived from this Constitution.

**Version**: 1.0.0 | **Ratified**: 2025-01-17 | **Last Amended**: 2025-01-17
