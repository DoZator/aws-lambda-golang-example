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
	sam local start-api -p 4000 --config-env dev

start: build zip start_api

deploy_sam:
	@echo "Deploy with sam..."
	sam deploy -t template.yml --config-env prod --s3-bucket aws-example-stack-bucket --no-confirm-changeset --no-fail-on-empty-changeset --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND --profile $(AWS_PROFILE)

deploy: build zip deploy_sam

delete:
	@echo "Delete..."
	aws cloudformation delete-stack --region $(AWS_REGION) --stack-name $(STACK_NAME) --profile $(AWS_PROFILE)
