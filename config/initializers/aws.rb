require "aws-sdk"

endpoint = Rails.application.credentials.minio_endpoint
user = Rails.application.credentials.minio_user
password = Rails.application.credentials.minio_password

Aws.config.update(
  endpoint: endpoint,
  access_key_id: user,
  secret_access_key: password,
  force_path_style: true,
  region: "us-east-1"
)

$s3 = Aws::S3::Client.new

def remove
  to_remove = []
  $s3.list_objects(bucket: "routes").contents.each do |file|
    if file.size == 0
      $s3.delete_object(key: file.key, bucket: "routes")
    end
  end
end
