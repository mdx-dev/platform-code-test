require_relative 'award'

# This class encapsulates the behavior of the Blue Star Award
# This award has the following properties:
#
# A Blue Star award's quality increases as it moves to expire:
#   if the award has not yet expired, increase quality by 1
#   if the award is past its expiry, decrease quality by 2
class BlueStar < Award
  def determine_quality_improvement
    return -2 if @expires_in.positive?

    -4
  end
end
