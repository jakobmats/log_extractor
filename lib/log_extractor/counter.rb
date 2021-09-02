# frozen_string_literal: true

module LogExtractor
  class Counter
    def initialize(entries)
      @entries = entries
    end

    def visits
      @visits ||= prepare
    end

    def uniq_visits
      @uniq_visits ||= prepare { |urls| urls.uniq(&:ip) }
    end

    def prepare
      @prepared ||= @entries
                   .group_by(&:url)
                   .map do |url, urls|
                      urls = yield urls if block_given?

                      Visit.new(url, urls.count)
                    end
                   .sort_by(&:count)
                   .reverse
    end

    private :prepare
  end
end
