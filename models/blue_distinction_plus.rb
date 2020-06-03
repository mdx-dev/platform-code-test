require_relative 'standard_award'

class BlueDistinctionPlus < StandardAward

  # never lose quality for this type
  def update_quality
    puts("update qual dist")
    return
  end

  def update_expiry
    puts("UPDATE BlueDIST ex")
  end
end
