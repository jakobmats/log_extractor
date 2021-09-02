# frozen_string_literal: true

require "log_extractor"

describe LogExtractor::Parser do
  context "parsing" do
    subject { LogExtractor::Parser.new }

    it "parses a line successfully" do
      entry = subject.parse("/help_page/1 126.318.035.038")

      expect(entry.url).to eq "/help_page/1"
      expect(entry.ip).to eq "126.318.035.038"
    end

    it "fails to parse a line" do
      expect { subject.parse("444.701.448.104") }.to raise_error(LogExtractor::ParseError)
    end
  end
end
