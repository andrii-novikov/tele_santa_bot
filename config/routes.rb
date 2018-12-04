Rails.application.routes.draw do
  default_url_options host: Rails.application.credentials[Rails.env.to_sym].dig(:default_host)
  telegram_webhook TelegramWebhooksController
end
