Rails.configuration.to_prepare do
  $event_store = RailsEventStore::Client.new
  $event_store.subscribe(Contexts::Routes::Commands::Create.new, to: [RouteWasCreated])
  $event_store.subscribe(Contexts::Routes::Commands::DeleteFileFromRoute.new, to: [FileWasDeletedFromRoute])
  $event_store.subscribe(Contexts::Routes::Commands::UpdateRoute.new, to: [RouteWasUpdated])
  $event_store.subscribe(Contexts::Ascends::Commands::AddLikeToAscend.new, to: [AscendWasLiked])
  $event_store.subscribe(Contexts::Ascends::Commands::ArchiveAscend.new, to: [AscendWasArchived])
  $event_store.subscribe(Contexts::Ascends::Commands::CreateAscend.new, to: [AscendWasCreated])
  $event_store.subscribe(Contexts::Ascends::Commands::UnlikeAscend.new, to: [AscendWasUnliked])
  $event_store.subscribe(Contexts::Users::Commands::CreateSingleUser.new, to: [UserWasCreated])
  $event_store.subscribe(Contexts::Users::Commands::UpdateUserProfileImage.new, to: [UserProfileImageWasUpdated])
  $event_store.subscribe(Contexts::Reservations::Commands::AddNewReservation.new, to: [ReservationWasAdded])
  $event_store.subscribe(Contexts::Gyms::Commands::AddNewGym.new, to: [GymWasAdded])
end
