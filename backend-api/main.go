package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
)

type Product struct {
	ID    int     `json:"id"`
	Name  string  `json:"name"`
	Price float64 `json:"price"`
}

var products = []Product{
	{ID: 1, Name: "Laptop", Price: 1200.00},
	{ID: 2, Name: "Mouse", Price: 25.50},
	{ID: 3, Name: "Keyboard", Price: 75.00},
}

// returns the list of products as JSON.
func productsHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("Handling /products request")
	w.Header().Set("Content-Type", "application/json")

	w.Header().Set("Access-Control-Allow-Origin", "*")
	json.NewEncoder(w).Encode(products)
}

// health checks.
func healthHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("Handling /health request")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "OK")
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8999"
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/products", productsHandler)
	mux.HandleFunc("/health", healthHandler)

	log.Printf("Server starting on port %s\n", port)
	if err := http.ListenAndServe(":"+port, mux); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
