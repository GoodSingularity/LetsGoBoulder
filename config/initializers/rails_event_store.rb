Rails.configuration.to_prepare do
  $event_store = RailsEventStore::Client.new
  $event_store.subscribe(Context::Routes::Commands::Create.new, to: [RouteWasCreated])
  $event_store.subscribe(Context::Routes::Commands::DeleteFileFromRoute.new, to: [FileWasDeletedFromRoute])
  $event_store.subscribe(Context::Routes::Commands::UpdateRoute.new, to: [RouteWasUpdated])
  $event_store.subscribe(Context::Ascends::Commands::AddLikeToAscend.new, to: [AscendWasLiked])
end
