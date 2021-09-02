# frozen_string_literal: true

require "log_extractor"

describe LogExtractor::Entry do
  context "new entry" do
    subject { LogExtractor::Entry.new("/help_page/1", "126.318.035.038") }

    it "creates a new entry" do
      expect(subject.url).to eq "/help_page/1"
      expect(subject.ip).to eq "126.318.035.038"
    end
  end
end
