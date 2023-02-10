require "i18n"
require "dummy_locale/version"
require "dummy_locale/locale"

module DummyLocale
  def self.generate(source_locale: :en, destination_locale: :zz)
    dummy_locale = Locale.new(
      source_locale: source_locale,
      destination_locale: destination_locale
    )

    dummy_locale.generate
    I18n.backend.class.prepend(reloader_for(dummy_locale))
  end

  def self.reloader_for(dummy_locale)
    Module.new do
      define_method "reload!" do
        super()
        dummy_locale.generate
      end
    end
  end
end
