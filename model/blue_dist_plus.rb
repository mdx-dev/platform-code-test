require_relative 'normal_award'

class BlueDistPlus < NormalAward
  def initialize(name, expires_in=0, quality=80)
    @name = name
    @expires_in = expires_in
    @quality = 80
  end

  def update!
    # Do nothing
    # Blue Distinct Plus never expire
  end
end
