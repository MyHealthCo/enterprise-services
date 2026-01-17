package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

// APIResponse represents the structure of the JSON response
type APIResponse struct {
	Message string `json:"message"`
	Status  string `json:"status"`
}

func jsonHandler(w http.ResponseWriter, r *http.Request) {
	response := APIResponse{
		Message: "Hello, World!",
		Status:  "ok",
	}

	w.WriteHeader(200)
	w.Header().Set("Content-Type", "application/json")

	if err := json.NewEncoder(w).Encode(response); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	response := APIResponse{
		Message: "Service is healthy",
		Status:  "ok",
	}

	w.WriteHeader(200)
	w.Header().Set("Content-Type", "application/json")

	if err := json.NewEncoder(w).Encode(response); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func setupRoutes() *http.ServeMux {
	mux := http.NewServeMux()
	mux.HandleFunc("/api", jsonHandler)
	mux.HandleFunc("/health", healthCheckHandler)
	return mux
}

func main() {
	mux := setupRoutes()
	port := 8080
	fmt.Printf("Starting server on :%d", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), mux))
}
