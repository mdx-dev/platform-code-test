class QUpdaterBase(object):
    """
    Normal Item
    """
    def update(self, exp, q):
        exp -= 1
        # First decrease if quality is positive
        q = (q - 1) if q > 0 else q
        # Second decrease if expiration is passed
        q = (q - 1) if (exp < 0 and q > 0) else q
        return exp, q

class Award(object):
    def __init__(self, name=None, expires_in=None, quality=None):
        self.name = name
        self.expires_in = expires_in
        self.quality = quality
