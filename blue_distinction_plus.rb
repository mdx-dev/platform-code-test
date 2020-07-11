require 'award'

class BlueDistinctionPlus < Award

  def initialize(expires_in, quality)
    super('Blue Distinction Plus', expires_in, 80)
  end  
  
  def update_quality  
  end 
end  