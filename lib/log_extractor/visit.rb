# frozen_string_literal: true

module LogExtractor
  Visit = Struct.new(:url, :count) do
    def to_s
      format("%s %d", url, count)
    end
  end
end
