# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket = "TF_BACKEND_S3_BUCKET"
#     key    = "global/s3/terraform.tfstate"
#     region = "AWS_REGION"

#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "TF_BACKEND_DYNAMO_TABLE"
#     encrypt        = true
#   }
# }
