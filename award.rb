Award = Struct.new(:name, :expires_in, :quality) do 

	def expired?
		expires_in < 0
	end

	def increment(x)
		if self.expired?
			self.quality += x*2
		else
			self.quality += x
		end
	end
end

