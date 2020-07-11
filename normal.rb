require 'award'

class Normal < Award

  	def initialize(expires_in, quality)
      super('Normal', expires_in, quality)
  	end  
  
  	def update_quality  
  		if self.quality > 0
  			self.quality -= 1
  		end
  		self.expires_in -= 1
  		if self.expires_in < 0 && self.quality > 0
        self.quality -= 1
      end
	end 
end  