from award import Award

class BlueStar(Award):
	def __init__(self, expires_in=None, quality=None):
		super(BlueStar, self).__init__('Blue Star', expires_in, quality)

	def update_quality(self):
		if self.quality > 0:
			self.quality -= 1
		if self.quality > 0:
			self.quality -= 1
		self.expires_in -= 1
		if self.expires_in < 0 and self.quality > 0:
			self.quality -= 1
		if self.expires_in < 0 and self.quality > 0:
			self.quality -= 1