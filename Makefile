STACK_NAME ?= aws-lambda-golang-example-stack

AWS_PROFILE ?= profile_name
AWS_REGION ?= us-east-1

.PHONY: build start_api start deploy

build:
	@echo "Building..."
	sam build

start_api:
	@echo "Start local..."
	sam local start-api

start: build start_api

deploy:
	@echo "Deploy..."
	sam build && sam deploy --region $(AWS_REGION) --stack-name $(STACK_NAME) --profile $(AWS_PROFILE) --guided

delete:
	@echo "Delete..."
	sam delete --region $(AWS_REGION) --stack-name $(STACK_NAME) --profile $(AWS_PROFILE)
