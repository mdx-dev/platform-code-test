# frozen_string_literal: true

# Award = Struct.new(:name, :expires_in, :quality)

class Award
  attr_reader :name
  attr_accessor :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    if @name != 'Blue First' && name != 'Blue Compare'
      @quality -= 1 if @quality.positive? && (@name != 'Blue Distinction Plus')
    elsif @quality < 50
      @quality += 1
      if @name == 'Blue Compare'
        @quality += 1 if @expires_in < (11) && (@quality < 50)
        @quality += 1 if @expires_in < (6) && (@quality < 50)
      end
    end
    @expires_in -= 1 if @name != 'Blue Distinction Plus'
    if @expires_in.negative?
      if @name != 'Blue First'
        if @name != 'Blue Compare'
          @quality -= 1 if @quality.positive? && (@name != 'Blue Distinction Plus')
        else
          @quality -= @quality
        end
      elsif @quality < 50
        @quality += 1
      end
    end
  end
end
