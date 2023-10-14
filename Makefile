STACK_NAME ?= aws-lambda-golang-example-stack

AWS_PROFILE ?= profile_name
AWS_REGION ?= us-east-1

.PHONY: build zip build_sam start_api start deploy_sam deploy

build:
	@echo "Building lambda binary..."
	GOOS=linux GOARCH=arm64 go build -tags lambda.norpc -o build/bootstrap cmd/lambda_app/main.go

zip:
	@echo "Zip lambda binary..."
	zip -j build/lambda_app.zip build/bootstrap

build_sam:
	@echo "Building with sam..."
	GOOS=linux GOARCH=arm64 CGO_ENABLED=0 sam build

start_api:
	@echo "Start local..."
	sam local start-api

start: build zip start_api

deploy_sam:
	@echo "Deploy with sam..."
	sam deploy --region $(AWS_REGION) --stack-name $(STACK_NAME) --profile $(AWS_PROFILE) --guided

deploy: build zip deploy_sam

delete:
	@echo "Delete..."
	sam delete --region $(AWS_REGION) --stack-name $(STACK_NAME) --profile $(AWS_PROFILE)
