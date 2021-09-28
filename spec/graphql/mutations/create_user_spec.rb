require "rails_helper"

class Mutations::CreateUserTest < ActiveSupport::TestCase
  def perform(name:, auth_provider:)
    Mutations::CreateUserMutation.new(object: nil, field: nil, context: {}).resolve(name: name, auth_provider: auth_provider)
  end

  test "create new user" do
    let(:email){
      Faker::Internet.email
    }
    user = perform(
      name: "Test User",
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
