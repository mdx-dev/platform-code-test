# frozen_string_literal: true

class Award
  class BlueFirst
    attr_reader :expires_in, :quality

    def self.match?(name)
      name == 'Blue First'
    end

    def initialize(initial_expires_in, initial_quality)
      @expires_in = initial_expires_in
      @quality = initial_quality
    end

    # I think there's some logic in the "Blue First" award that's not included in the README.
    def update!
      @expires_in -= 1
      @quality += 2
      @quality -= 1 if @expires_in.positive?
      @quality = QUALITY_UPPER_LIMIT if @quality > QUALITY_UPPER_LIMIT
    end
  end
end
