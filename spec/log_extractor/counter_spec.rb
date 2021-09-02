# frozen_string_literal: true

require "log_extractor"

describe LogExtractor::Counter do
  it "counts a single visit" do
    counter = LogExtractor::Counter.new([LogExtractor::Entry.new("/contact", "836.973.694.403")])

    visits = counter.visits

    expect(visits.first.count).to eq 1
  end

  it "counts indentical visits" do
    counter = LogExtractor::Counter.new([
                                          LogExtractor::Entry.new("/contact", "836.973.694.403"),
                                          LogExtractor::Entry.new("/contact", "836.973.694.403")
                                        ])

    visits = counter.visits

    expect(visits.first.count).to eq 2
  end

  it "counts differing visits" do
    counter = LogExtractor::Counter.new([
                                          LogExtractor::Entry.new("/contact", "682.704.613.213"),
                                          LogExtractor::Entry.new("/about/2", "555.576.836.194"),
                                          LogExtractor::Entry.new("/about", "016.464.657.359"),
                                          LogExtractor::Entry.new("/index", "897.280.786.156"),
                                          LogExtractor::Entry.new("/about/2", "184.123.665.067"),
                                          LogExtractor::Entry.new("/index", "555.576.836.194")
                                        ])

    visits = counter.visits

    expect(visits).to eq [
      LogExtractor::Visit.new("/index", 2),
      LogExtractor::Visit.new("/about/2", 2),
      LogExtractor::Visit.new("/about", 1),
      LogExtractor::Visit.new("/contact", 1)
    ]
  end

  it "counts unique visits" do
    counter = LogExtractor::Counter.new([
                                          LogExtractor::Entry.new("/index", "217.511.476.080"),
                                          LogExtractor::Entry.new("/index", "715.156.286.412"),
                                          LogExtractor::Entry.new("/index", "235.313.352.950"),
                                          LogExtractor::Entry.new("/index", "451.106.204.921"),
                                          LogExtractor::Entry.new("/index", "682.704.613.213"),
                                          LogExtractor::Entry.new("/index", "235.313.352.950") # impostor
                                        ])

    visits = counter.uniq_visits

    expect(visits).to eq [
      LogExtractor::Visit.new("/index", 5)
    ]
  end
end
