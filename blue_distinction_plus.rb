require "award"

class BlueDistinctionPlus < Award
  def initialize(expires_in_days:)
    super(:expires_in_days => expires_in_days, :quality => 80)
  end

  private

  def init_quality(value)
    @quality = 80
  end

  def step_quality
    @quality
  end
end
