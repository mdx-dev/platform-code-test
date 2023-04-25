from award_quality_decay_processors import retrieve_processor


class Award(object):
    def __init__(
        self, name: str = None, expires_in: int = None, quality: int = None
    ) -> None:
        self.name = name
        self.expires_in = expires_in
        self.quality = quality

    @property
    def quality(self) -> int:
        return self._quality

    @quality.setter
    def quality(self, value: int):
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

    def decrement_expires_in(self, amount: int = 1):
        if self.name == "Blue Distinction Plus":
            return

        self.expires_in -= amount

    def decay_quality(self) -> None:
        retrieve_processor(self).decay()
