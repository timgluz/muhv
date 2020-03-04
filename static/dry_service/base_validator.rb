class BaseValidator < Dry::Validation::Contract
  attr_reader :args, :locale, :full_messages

  DEFAULT_ERROR_LOCALE = :en

  config.messages.default_locale = DEFAULT_ERROR_LOCALE
  config.messages.backend = :i18n
  config.messages.top_namespace = :validators

  def self.call(**args)
    args = args.to_h.deep_symbolize_keys
    locale = args[:locale] || DEFAULT_ERROR_LOCALE
    full_messages = args[:full_messages] || false

    new.call(**args)
      .to_monad
      .fmap { |res| res.to_h }
      .or { |res| Dry::Monads::Failure(res.errors(locale: locale, full_messages: full_messages).to_h) }
  end
end
