# frozen_string_literal: true

class Award
  class BlueStar
    attr_reader :expires_in, :quality

    def self.match?(name)
      name == 'Blue Star'
    end

    def initialize(initial_expires_in, initial_quality)
      @expires_in = initial_expires_in
      @quality = initial_quality
    end

    def update!
      @expires_in -= 1
      @quality -= 2
      @quality -= 2 if @expires_in.negative?
      @quality = 0 if @quality.negative?
    end
  end
end
