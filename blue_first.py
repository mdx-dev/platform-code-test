from award import Award

class BlueFirst(Award):
	def __init__(self, expires_in=None, quality=None):
		super(BlueFirst, self).__init__('Blue First', expires_in, quality)

	def update_quality(self):
		if self.quality < 50:
			self.quality += 1

		self.expires_in -= 1
		if self.expires_in < 0 and self.quality < 50:
			self.quality += 1