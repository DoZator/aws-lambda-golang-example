package routes

import (
	"aws-lambda-golang-example/internal/models"
	"aws-lambda-golang-example/internal/render"
	"net/http"
)

func MainHandler(w http.ResponseWriter, r *http.Request) {
	resp := models.NewResponse()
	render.OK(w, r, resp)
}
