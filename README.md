## Golang AWS Lambda example

### Local development

Invoking function locally through local API Gateway

```bash
make start
```

or

```bash
sam build && sam local start-api
```

To deploy your application for the first time, run the following in your shell:

```bash
sam build && sam deploy --stack-name aws-lambda-golang-example --guided
```

or

```bash
make deploy
```
