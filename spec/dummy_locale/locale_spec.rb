module DummyLocale
  describe Locale do
    describe "#generate" do
      it "wraps all translations from the source locale" do
        source_translations = { posts: { header: "test" } }
        I18n.backend.store_translations(:en, source_translations)

        locale = Locale.new(source_locale: :en, destination_locale: :zz)
        locale.generate

        expect(I18n.t("posts.header", locale: :zz)).to eq "ZZtestZZ"
      end

      it "wraps array translations from the source locale" do
        day_names = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
        source_translations = {
          date: {
            formats: {
              day_names: day_names,
            },
          },
        }
        I18n.backend.store_translations(:en, source_translations)

        locale = Locale.new(source_locale: :en, destination_locale: :zz)
        locale.generate

        expect(I18n.t("date.formats.day_names", locale: :zz)).to eq [
          "ZZSundayZZ",
          "ZZMondayZZ",
          "ZZTuesdayZZ",
          "ZZWednesdayZZ",
          "ZZThursdayZZ",
          "ZZFridayZZ",
          "ZZSaturdayZZ",
        ]
      end
    end
  end
end
