require "rails_helper"

class Mutations::CreateUserTest < ActiveSupport::TestCase
  def perform(name:, auth_provider:, phone_number:)
    Mutations::CreateUserMutation.new(object: nil, field: nil, context: {}).resolve(name: name, phone_number: phone_number, auth_provider: auth_provider)
  end

  test "create new user" do
    let(:email) {
      Faker::Internet.email
    }
        
    user = perform(
      name: "Test User",
      phone_number: 667089810,
      auth_provider: {
        credentials: {
          email: email,
          password: "[omitted]"
        }
      }
    )

    assert user.persisted?
    assert_equal user.name, "Test User"
    assert_equal user.email, email
  end
end
