from award import Award

class Normal(Award):
	def __init__(self, expires_in=None, quality=None):
		super(Normal, self).__init__('Normal', expires_in, quality)

	def update_quality(self):
		if self.quality > 0:
			self.quality -= 1

		self.expires_in -= 1
		if self.expires_in < 0 and self.quality > 0:
			self.quality -= 1