require_relative 'standard_award'

class BlueStar < StandardAward

  def update_quality
    if @expires_in > 0
      decrement_quality
      decrement_quality
    else
      4.times do
        decrement_quality
      end
    end
    decrement_expiry
  end
  
end
