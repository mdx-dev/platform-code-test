require_relative 'award.rb'

# This class encapsulates the behavior of the Blue Distinction Plus Award
# This award has the following properties:
#
# A Blue Distinction Plus award has quality of 80 and it never changes.
# A Blue Distinction Plus award never expires
class BlueDistinctionPlus < Award

  def initialize(**kwargs)
    expires_in_arg = kwargs[:expires_in]
    super(quality: 80, expires_in: expires_in_arg)
  end

  # Intentional No-Op
  def update_quality
    self
  end

end