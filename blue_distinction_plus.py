from award import Award

class BlueDistinctionPlus(Award):
	def __init__(self, expires_in=None, quality=None):
		super(BlueDistinctionPlus, self).__init__('Blue Distinction Plus', expires_in, 80)

	def update_quality(self):
		pass