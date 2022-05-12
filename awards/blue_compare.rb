require_relative 'award'

# This class encapsulates the behavior of the Blue Compare Award
# This award has the following properties:
#
# A Blue Compare award's quality increases as it moves to expire:
#   10 <= expires_in < 5 : quality increases by 2
#   5 <= expires_in < 0 : quality increases by 3
#   0 <= expires_in : quality becomes 0
class BlueCompare < Award
  def determine_quality_improvement
    return 1 if @expires_in > 10
    return 2 if @expires_in > 5
    return 3 if @expires_in.positive?

    -@quality
  end
end
