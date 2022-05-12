require_relative 'award'

# This class encapsulates the behavior of the Blue Distinction Plus Award
# This award has the following properties:
#
# A Blue Distinction Plus award has quality of 80 and it never changes.
# A Blue Distinction Plus award never expires
class BlueDistinctionPlus < Award
  def initialize
    super(quality: 80, expires_in: 0)
  end

  # Intentional No-Op
  def update_quality
    self
  end
end
