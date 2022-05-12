# frozen_string_literal: true

class Award
  class BlueCompare
    attr_reader :expires_in, :quality

    def self.match?(name)
      name == 'Blue Compare'
    end

    def initialize(initial_expires_in, initial_quality)
      @expires_in = initial_expires_in
      @quality = initial_quality
    end

    def update!
      @expires_in -= 1

      @quality += (
        case @expires_in
        when 10..nil
          1
        when nil..4
          3
        when 4..10
          2
        else
          raise adfadsf
        end
      )

      @quality = QUALITY_UPPER_LIMIT if @quality > QUALITY_UPPER_LIMIT
      @quality = 0 if @expires_in.negative?
    end
  end
end
