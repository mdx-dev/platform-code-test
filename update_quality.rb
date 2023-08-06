class Award
  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    return if @name == "Blue Distinction Plus"

    if @name == "Blue First"
      @quality = [@quality + 1, 50].min
    elsif @name == "Blue Compare"
      if @expires_in <= 0
        @quality = 0
      elsif @expires_in <= 5
        @quality = [@quality + 3, 50].min
      elsif @expires_in <= 10
        @quality = [@quality + 2, 50].min
      else
        @quality = [@quality + 1, 50].min
      end
    elsif @name == "Blue Star"
      # Blue Star loses quality twice as fast as normal awards
      if @expires_in <= 0
        @quality = 0
      else
        @quality = [@quality - 2, 0].max
      end
    else
      # Normal awards lose quality twice as fast after the expiration date
      if @expires_in <= 0
        @quality = [@quality - 2, 0].max
      else
        @quality = [@quality - 1, 0].max
      end
    end

    @expires_in -= 1
  end
end

def update_quality(awards)
  awards.each(&:update_quality)
end
