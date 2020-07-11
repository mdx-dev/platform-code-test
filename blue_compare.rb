require 'award'

class BlueCompare < Award
	def initialize(expires_in, quality)
    super('Blue Compare', expires_in, quality)
  end  
  
  def update_quality  
  	if self.quality < 50
   		self.quality +=1
  		if self.expires_in < 11 && self.quality < 50
        self.quality += 1
      end
      if self.expires_in < 6 && self.quality < 50
        self.quality += 1 
      end
  	end
  	self.expires_in -= 1
  	if self.expires_in < 0
  		self.quality = 0
  	end 
  end 
end  
