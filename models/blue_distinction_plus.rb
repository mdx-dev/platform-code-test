require_relative 'standard_award'

class BlueDistinctionPlus < StandardAward
  # never lose quality for this type, expiry doesn't decrement
  def update_quality
  end
end
