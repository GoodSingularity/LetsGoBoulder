require "rails_helper"

RSpec.describe Mutations::CreateUserMutation, type: :request do
  let(:email) {
    Faker::Internet.email
  }
  let(:file) {
    fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "image.jpg"), "image/jpg")
  }

  let(:auth_provider) {
    {
      credentials: {
        email: email,
        password: "[omitted]"
      }
    }
  }

  describe ".mutation passes" do
    it "create new user" do
      user = Mutations::CreateUserMutation.new(object: nil, field: nil, context: {}).resolve(
        name: "Test User",
        phone_number: 667089810,
        auth_provider: auth_provider,
        file: file,
        gender: 0
      )
      assert user.persisted?
      assert_equal user.name, "Test User"
      assert_equal user.email, email
      expect { $s3.get_object(bucket: "avatars", key: user.avatar_id) }.to_not raise_error(Aws::S3::Errors::NoSuchKey)
      $s3.delete_object(key: user.avatar_id, bucket: "avatars")
    end
  end
end
