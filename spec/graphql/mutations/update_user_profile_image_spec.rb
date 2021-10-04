  require "rails_helper"


    RSpec.describe Mutations::UpdateUserProfileImageMutation, type: :request do

      let(:file){
        fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "image.jpg"), "image/jpg")
      }
      let(:user){
        User.create(email: Faker::Internet.email, password_digest: "test", phone_number: 667089810, name: "test")
      }


      describe ".mutation passes" do
        it "create new user" do
          Mutations::UpdateUserProfileImageMutation.new(object: nil, field: nil, context: {current_user: user}).resolve(
            id: user.id,
            file: file
          )
          user.reload
          expect(user.avatar_id).to_not be(nil)
          expect{ $s3.get_object(bucket: "avatars", key: user.avatar_id) }.to_not raise_error
        end
      end
    end
