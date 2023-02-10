require "i18n"
require "dummy_locale/version"
require "dummy_locale/locale"


# DummyLocale builds a complete copy of the source locale at runtime, modifying
# each translated string in a way that allows you to easily distinguish
# internationalized strings from hard-coded strings when doing UI testing.
module DummyLocale

  # Creates the dummy locale from the source locale and hooks `I18n.reload!`
  #
  # When Rails or other code calls `I18n.reload!` to pick up new and modified
  # entries, DummyLocale will regenerate the locale from the updated source.
  # This helps us seamlessly pick up translation changes in development.
  def self.generate(source_locale: :en, destination_locale: :zz)
    dummy_locale = Locale.new(
      source_locale: source_locale,
      destination_locale: destination_locale
    )

    dummy_locale.generate
    I18n.backend.class.prepend(reloader_for(dummy_locale))
  end

  # Generates a module that is aware of DummyLocale
  def self.reloader_for(dummy_locale)
    Module.new do
      define_method "reload!" do
        super()
        dummy_locale.generate
      end
    end
  end
end
