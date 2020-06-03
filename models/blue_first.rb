require_relative 'standard_award'

class BlueFirst < StandardAward
  def update_quality
    #increment a 2x for being old
    if @expires_in <= 0
      increment_quality
      increment_quality
    else
      increment_quality
    end

    decrement_expiry
  end

  def increment_quality
    if @quality < 50
      @quality += 1
    end
  end
end
