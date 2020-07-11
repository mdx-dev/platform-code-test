from award import Award

class BlueCompare(Award):
	def __init__(self, expires_in=None, quality=None):
		super(BlueCompare, self).__init__('Blue Compare', expires_in, quality)

	def update_quality(self):
		if self.quality < 50:
			self.quality += 1
			if self.expires_in < 11 and self.quality < 50:
				self.quality += 1
			if self.expires_in < 6 and self.quality < 50:
				self.quality += 1 


		self.expires_in -= 1
		if self.expires_in < 0:
			self.quality = 0