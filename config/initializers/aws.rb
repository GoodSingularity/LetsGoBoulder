require "aws-sdk"

Aws.config.update(
  endpoint: "http://localhost:9000",
  access_key_id: "minioadmin",
  secret_access_key: "minioadmin",
  force_path_style: true,
  region: "us-east-1"
)

@s3 = Aws::S3::Client.new
