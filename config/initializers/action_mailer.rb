mailer_config = Rails.application.config_for(:action_mailer)

Rails.application.routes.default_url_options[:host] = mailer_config['host']
Rails.application.config.action_mailer.delivery_method = :smtp
Rails.application.config.action_mailer.smtp_settings = mailer_config['smtp_settings']
Rails.application.config.x.email_address = mailer_config['email_address']
