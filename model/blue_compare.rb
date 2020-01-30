require_relative 'normal_award'

class BlueCompare < NormalAward
  LONG_EXPIRED = 10
  MEDIUM_EXPIRED = 5

  # Blue Compare increase value each day before expires
  # Increase 2 under 10 days
  # Increase 3 under 5 days
  # Become 0 when it expires

  def update!
    if @expires_in > LONG_EXPIRED
      add = 1
    elsif @expires_in > MEDIUM_EXPIRED
      add = 2
    elsif @expires_in > 0
      add = 3
    end

    @quality = @expires_in > 0 ? [@quality + add, 50].min : 0
    @expires_in -= 1
  end
end
