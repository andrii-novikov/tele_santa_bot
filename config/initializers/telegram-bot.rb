Telegram::Bot::Client.typed_response!
Telegram::Bot::UpdatesController.config.session_store = ActiveSupport::Cache.lookup_store(:memory_store)