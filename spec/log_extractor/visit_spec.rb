# frozen_string_literal: true

require "log_extractor"

describe LogExtractor::Visit do
  subject do
    LogExtractor::Visit.new(
      "/help_page/1",
      10
    )
  end

  it "creates a new visit" do
    expect(subject.url).to eq "/help_page/1"
    expect(subject.count).to eq 10
  end

  it "converts visit to string" do
    expect(subject.to_s).to eq "/help_page/1 10"
  end
end
