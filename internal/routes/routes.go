package routes

import (
	chiadapter "github.com/awslabs/aws-lambda-go-api-proxy/chi"
	"github.com/go-chi/chi/v5"
)

func GetLambdaAdapter() *chiadapter.ChiLambda {
	r := chi.NewRouter()

	r.Get("/api/test", MainHandler)

	return chiadapter.New(r)
}
