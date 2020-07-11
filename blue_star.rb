require 'award'

class BlueStar < Award
  
  	def initialize(expires_in, quality)
       super('Blue Star', expires_in, quality)
  	end  
  
  	def update_quality  
  		if self.quality > 0
  			self.quality -= 1
  		end
      if self.quality > 0
        self.quality -= 1
      end
  		self.expires_in -= 1
  		if self.expires_in < 0 && self.quality > 0
        self.quality -= 1
      end
      if self.expires_in < 0 && self.quality > 0
        self.quality -= 1
      end
	end 
end  