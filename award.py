class Award(object):
    def __init__(self, name=None, expires_in=None, quality=None):
        self.name = name
        self.expires_in = expires_in
        self.quality = quality

    @property
    def quality(self):
        return self._quality

    @quality.setter
    def quality(self, value):
        if self.name == "Blue Distinction Plus":
            self._quality = 80
            return

        if value < 0:
            self._quality = 0
            return

        if value > 50:
            self._quality = 50
            return

        self._quality = value
