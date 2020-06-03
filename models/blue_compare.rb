require_relative 'standard_award'

class BlueCompare < StandardAward
  INFINITY = +1.0/0.0
  NEGATIVE_INFINITY = -1.0/0.0

  def update_quality
    case @expires_in
    when 11..INFINITY
      increment_quality
    when 6..10
      increment_quality
      increment_quality
    when 1..5
      3.times do
        increment_quality
      end
    when NEGATIVE_INFINITY..0
      @quality = 0
    end
    decrement_expiry
  end

end
