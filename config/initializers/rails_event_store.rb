Rails.configuration.to_prepare do
  $event_store = RailsEventStore::Client.new
  $event_store.subscribe(Context::Routes::Commands::Create.new, to: [RouteCreated])
  $event_store.subscribe(Context::Routes::Commands::DeleteFileFromRoute.new, to: [FileWasDeletedFromRoute])
end
