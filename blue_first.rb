require 'award'

class BlueFirst < Award

  def initialize(expires_in, quality)
    super('Blue First', expires_in, quality)
  end  
  
  def update_quality  
    if self.quality < 50
      self.quality +=1
    end
    self.expires_in -= 1
    if self.expires_in < 0 && self.quality < 50
      self.quality += 1
    end
  end 
end  
