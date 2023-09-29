package render

import (
	"github.com/go-chi/render"
	"net/http"
)

func OK(w http.ResponseWriter, r *http.Request, v interface{}) {
	render.Status(r, http.StatusOK)
	render.JSON(w, r, v)
}
