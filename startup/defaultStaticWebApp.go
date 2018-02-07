package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	port := fmt.Sprintf(":%s", os.Getenv("PORT"))
    http.HandleFunc("/", f)
    fmt.Println("Starting default static web app...")
	http.ListenAndServe(port, nil)
}

func f(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "/home/site/wwwroot/hostingstart.html")
}
