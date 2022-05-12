require_relative 'award'

# This class encapsulates the behavior of the Blue First Award
# This award has the following properties:
#
# A Blue First award's quality increases as it moves to expire:
#   if the award has not yet expired, increase quality by 1
#   if the award is past its expiry, increase quality by 2
class BlueFirst < Award
  def determine_quality_improvement
    return 1 if @expires_in.positive?

    2
  end
end
