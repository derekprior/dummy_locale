require "i18n"
require "dummy_locale/version"
require "dummy_locale/locale"

module DummyLocale
  def self.generate(*args)
    dummy_locale = Locale.new(*args)
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
