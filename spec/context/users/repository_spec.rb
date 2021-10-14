require "rails_helper"
require "faker"

RSpec.describe Context::Users::Repository, type: :model do
  context "create method" do
    it "it success" do
      auth_provider = {
        credentials: {
          email: Faker::Internet.email,
          password: "12345678910"
        }
      }
      event_store = Context::Users::Repository.new.create_user(auth_provider: auth_provider, name: Faker::Name.name, phone_number: 667089810, avatar_id: SecureRandom.uuid)
      expect(event_store).to have_published(an_event(UserWasCreated))
    end
  end

  context "update method" do
    let(:user) {
      User.create!(id: SecureRandom.uuid, name: Faker::Name.name, email: Faker::Internet.email, phone_number: 667089810, password_digest: "12345678910")
    }

    let(:file) {
      fixture_file_upload(
        Rails.root.join(
          "spec",
          "fixtures",
          "files",
          "image.jpg"
        ),
        "image/jpg"
      )
    }

    it "it success" do
      event_store = Context::Users::Repository.new.update(
        id: user.id,
        file: file
      )
      expect(event_store).to have_published(an_event(UserProfileImageWasUpdated))
    end
  end
end
