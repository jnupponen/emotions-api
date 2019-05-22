
BUCKET_NAME=jnupponen-emotions-api-artifacts
AWS_PROFILE=jnupponen-demo-dev



init:
	AWS_PROFILE=${AWS_PROFILE} aws s3 mb s3://${BUCKET_NAME}

deploy: sam_package sam_deploy sam_output

sam_package:
	AWS_PROFILE=${AWS_PROFILE} sam package \
        --output-template-file packaged.yaml \
        --s3-bucket ${BUCKET_NAME}

sam_deploy:
	AWS_PROFILE=${AWS_PROFILE} sam deploy \
        --template-file packaged.yaml \
        --stack-name emotions-api \
        --capabilities CAPABILITY_IAM

sam_output:
	AWS_PROFILE=${AWS_PROFILE} aws cloudformation describe-stacks \
        --stack-name emotions-api \
        --query 'Stacks[].Outputs[?OutputKey==`HelloWorldApi`]' \
        --output table
