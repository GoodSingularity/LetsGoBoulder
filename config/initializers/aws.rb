require "aws-sdk"

Aws.config.update(
  endpoint: ENV["MINIO_ENDPOINT"],
  access_key_id: "minioadmin",
  secret_access_key: "minioadmin",
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
