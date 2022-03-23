# frozen_string_literal: true

# Award = Struct.new(:name, :expires_in, :quality)

class Award
  BLUE_FIRST = 'Blue First'
  BLUE_COMPARE = 'Blue Compare'
  BLUE_DISTINCT_PLUS = 'Blue Distinction Plus'

  attr_reader :name
  attr_accessor :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    if @name != BLUE_FIRST && name != BLUE_COMPARE
      @quality -= 1 if @quality.positive? && (@name != BLUE_DISTINCT_PLUS)
    elsif @quality < 50
      @quality += 1
      if @name == BLUE_COMPARE
        @quality += 1 if @expires_in < (11) && (@quality < 50)
        @quality += 1 if @expires_in < (6) && (@quality < 50)
      end
    end
    @expires_in -= 1 if @name != BLUE_DISTINCT_PLUS
    if @expires_in.negative?
      if @name != BLUE_FIRST
        if @name != BLUE_COMPARE
          @quality -= 1 if @quality.positive? && (@name != BLUE_DISTINCT_PLUS)
        else
          @quality -= @quality
        end
      elsif @quality < 50
        @quality += 1
      end
    end
  end
end
