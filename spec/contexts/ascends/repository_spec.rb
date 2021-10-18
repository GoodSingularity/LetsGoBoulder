require "rails_helper"
require "faker"

RSpec.describe Contexts::Ascends::Repository, type: :model do
  context "create method" do
    let(:route) {
      Route.create!(
        id: SecureRandom.uuid,
        color: 1,
        route_setter: Faker::Name.name,
        name: SecureRandom.uuid
      )
    }
    let(:user) {
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password_digest: "123456",
        phone_number: 667089810
      )
    }
    it "it success" do
      args = {
        route_id: route.id,
        user_id: user.id,
        is_flashed: true
      }
      event_store = Contexts::Ascends::Repository.new.create_ascend(args: args)
      expect(event_store).to have_published(an_event(AscendWasCreated))
    end
  end

  context "add like method" do
    let(:route) {
      Route.create!(
        id: SecureRandom.uuid,
        color: 1,
        route_setter: Faker::Name.name,
        name: SecureRandom.uuid
      )
    }

    let(:user) {
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password_digest: "123456",
        phone_number: 667089810
      )
    }

    let(:ascend) {
      Ascend.create(
        id: SecureRandom.uuid,
        user_id: user.id,
        route_id: route.id,
        is_flashed: true,
        likes: [],
        archive: false
      )
    }

    it "it success" do
      args = {
        id: ascend.id
      }
      event_store = Contexts::Ascends::Repository.new.add_like(args: args, current_user_id: user.id)
      expect(event_store).to have_published(an_event(AscendWasLiked))
      ascend.reload
      expect(ascend.likes).equal?([user.id])
    end
  end

  context "unlike method" do
    let(:route) {
      Route.create!(
        id: SecureRandom.uuid,
        color: 1,
        route_setter: Faker::Name.name,
        name: SecureRandom.uuid
      )
    }

    let(:user) {
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password_digest: "123456",
        phone_number: 667089810
      )
    }

    let(:ascend) {
      Ascend.create(
        id: SecureRandom.uuid,
        user_id: user.id,
        route_id: route.id,
        is_flashed: true,
        likes: [user.id],
        archive: false
      )
    }

    it "it success" do
      event_store = Contexts::Ascends::Repository.new.unlike(
        ascend_id: ascend.id,
        current_user_id: user.id
      )
      expect(event_store).to have_published(an_event(AscendWasUnliked))
      ascend.reload
      expect(ascend.likes).equal?([])
    end
  end

  context "archive ascend method" do
    let(:route) {
      Route.create!(
        id: SecureRandom.uuid,
        color: 1,
        route_setter: Faker::Name.name,
        name: SecureRandom.uuid
      )
    }

    let(:user) {
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password_digest: "123456",
        phone_number: 667089810
      )
    }

    let(:ascend) {
      Ascend.create(
        id: SecureRandom.uuid,
        user_id: user.id,
        route_id: route.id,
        is_flashed: true,
        likes: [user.id],
        archive: false
      )
    }

    it "it success" do
      event_store = Contexts::Ascends::Repository.new.archive_ascend(
        id: ascend.id
      )
      expect(event_store).to have_published(an_event(AscendWasArchived))
      ascend.reload
      expect(ascend.archive).equal?(true)
    end
  end
end
