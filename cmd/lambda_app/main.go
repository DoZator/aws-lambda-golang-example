package main

import (
	"aws-lambda-golang-example/internal/routes"
	"context"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	chiadapter "github.com/awslabs/aws-lambda-go-api-proxy/chi"
)

var adapter *chiadapter.ChiLambda

func init() {
	adapter = routes.GetLambdaAdapter()
}

func main() {
	lambda.Start(lambdaHandler)
}

func lambdaHandler(ctx context.Context, r events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return adapter.ProxyWithContext(ctx, r)
}
