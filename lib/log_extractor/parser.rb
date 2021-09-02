# frozen_string_literal: true

module LogExtractor
  ParseError = Class.new(StandardError)

  class Parser
    def parse(line)
      (url, ip) = line.split(" ")

      raise ParseError if url.nil? || ip.nil?

      Entry.new(url, ip)
    end
  end
end
