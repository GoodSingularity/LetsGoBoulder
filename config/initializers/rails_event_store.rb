Rails.configuration.to_prepare do
  $event_store = RailsEventStore::Client.new
  $event_store.subscribe(Context::Routes::Commands::Create.new, to: [RouteCreated])
end
