# frozen_string_literal: true

class Award
  class BlueDistinctionPlus
    attr_reader :expires_in, :quality

    def self.match?(name)
      name == 'Blue Distinction Plus'
    end

    def initialize(initial_expires_in, _initial_quality)
      @expires_in = initial_expires_in
      @quality = 80
    end

    def update!; end
  end
end
