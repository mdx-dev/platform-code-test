# frozen_string_literal: true

require 'forwardable'

class Award
  extend Forwardable
  def_delegators :@award, :update!, :quality, :expires_in
  attr_accessor :name

  QUALITY_UPPER_LIMIT = 50

  private_constant :QUALITY_UPPER_LIMIT

  def initialize(name, initial_expires_in, initial_quality)
    @name = name

    case
    when BlueStar.match?(name)
      @award = BlueStar.new initial_expires_in, initial_quality
      # p award

    when BlueFirst.match?(name)
      @award = BlueFirst.new initial_expires_in, initial_quality

    when BlueDistinctionPlus.match?(name)
      @award = BlueDistinctionPlus.new initial_expires_in, initial_quality

    when BlueCompare.match?(name)
      @award = BlueCompare.new initial_expires_in, initial_quality

    when NormalItem.match?(name)
      @award = NormalItem.new initial_expires_in, initial_quality

    else
      return
    end
  end

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

  class NormalItem
    attr_reader :expires_in, :quality

    def self.match?(name)
      name == 'NORMAL ITEM'
    end

    def initialize(initial_expires_in, initial_quality)
      @expires_in = initial_expires_in
      @quality = initial_quality
    end

    def update!
      @expires_in -= 1
      @quality -= 1
      @quality -= 1 if @expires_in.negative?
      @quality = 0 if @quality.negative?
    end
  end
end
