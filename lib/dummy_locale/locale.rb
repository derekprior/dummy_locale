require "active_support/core_ext/hash"

module DummyLocale
  class Locale
    def initialize(source_locale: :en, destination_locale: :zz)
      @source_locale = source_locale.to_sym
      @destination_locale = destination_locale.to_sym
      @tag = destination_locale.to_s.upcase
    end

    # Generates the destination locale from the source locale
    #
    # Wraps the translated values in an upcased version of the destination
    # locale specifier and adds the destination locale to the list of available
    # locales.
    def generate
      I18n.backend.load_translations
      translations = wrap(source_translations)
      I18n.backend.store_translations(destination_locale, translations)
      I18n.available_locales += [destination_locale]
    end

    private

    attr_reader :source_locale, :destination_locale, :tag

    def source_translations
      I18n.backend.send(:translations)[source_locale] ||
        raise("Unable to find source translations for #{source_locale}")
    end

    def wrap(translations)
      case translations
      when Hash
        translations.transform_values { |value| wrap(value) }
      when Array
        translations.map { |item| wrap(item) }
      else
        wrap_with_tag(translations)
      end
    end

    def wrap_with_tag(translation)
      "#{tag}#{translation}#{tag}"
    end
  end
end
