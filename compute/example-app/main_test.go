package main

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestJsonHandler(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/api", nil)
	rec := httptest.NewRecorder()

	jsonHandler(rec, req)

	if rec.Code != http.StatusOK {
		t.Errorf("expected status %d, got %d", http.StatusOK, rec.Code)
	}

	var response APIResponse
	if err := json.NewDecoder(rec.Body).Decode(&response); err != nil {
		t.Fatalf("failed to decode response: %v", err)
	}

	if response.Message != "Hello, World!" {
		t.Errorf("expected message %q, got %q", "Hello, World!", response.Message)
	}

	if response.Status != "ok" {
		t.Errorf("expected status %q, got %q", "ok", response.Status)
	}
}

func TestHealthCheckHandler(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/health", nil)
	rec := httptest.NewRecorder()

	healthCheckHandler(rec, req)

	if rec.Code != http.StatusOK {
		t.Errorf("expected status %d, got %d", http.StatusOK, rec.Code)
	}

	var response APIResponse
	if err := json.NewDecoder(rec.Body).Decode(&response); err != nil {
		t.Fatalf("failed to decode response: %v", err)
	}

	if response.Message != "Service is healthy" {
		t.Errorf("expected message %q, got %q", "Service is healthy", response.Message)
	}

	if response.Status != "ok" {
		t.Errorf("expected status %q, got %q", "ok", response.Status)
	}
}

func TestSetupRoutes(t *testing.T) {
	mux := setupRoutes()

	if mux == nil {
		t.Fatal("setupRoutes returned nil")
	}

	tests := []struct {
		name            string
		path            string
		expectedMessage string
	}{
		{"api route", "/api", "Hello, World!"},
		{"health route", "/health", "Service is healthy"},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			req := httptest.NewRequest(http.MethodGet, tt.path, nil)
			rec := httptest.NewRecorder()

			mux.ServeHTTP(rec, req)

			if rec.Code != http.StatusOK {
				t.Errorf("expected status %d, got %d", http.StatusOK, rec.Code)
			}

			var response APIResponse
			if err := json.NewDecoder(rec.Body).Decode(&response); err != nil {
				t.Fatalf("failed to decode response: %v", err)
			}

			if response.Message != tt.expectedMessage {
				t.Errorf("expected message %q, got %q", tt.expectedMessage, response.Message)
			}
		})
	}
}
