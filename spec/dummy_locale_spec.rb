require "spec_helper"

describe DummyLocale do
  describe ".generate" do
    it "Generates the dummy locale which survives reloads" do
      I18n.load_path += Dir[File.dirname(__FILE__) + "/fixtures/*.yml"]
      DummyLocale.generate(source_locale: :en, destination_locale: :zz)
      I18n.reload!

      expect(I18n.t(:key, locale: :en)).to eq "value"
      expect(I18n.t(:key, locale: :zz)).to eq "ZZvalueZZ"

      I18n.reload!
      expect(I18n.t(:key, locale: :en)).to eq "value"
      expect(I18n.t(:key, locale: :zz)).to eq "ZZvalueZZ"
    end
  end
end
