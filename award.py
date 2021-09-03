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

class QUpdaterBlueFirst(QUpdaterBase):
    # Inherits QUpdaterBase Class
    """
    Blue First Item
    """
    def update(self, exp, q):
        # First increase quality is still under 50
        q = (q + 1) if q < 50 else q
        exp -= 1
        # Second increase if expiration date passed
        q = (q + 1) if exp < 0 and q < 50 else q
        return exp, q

class Award(object):
    def __init__(self, name=None, expires_in=None, quality=None):
        self.name = name
        self.expires_in = expires_in
        self.quality = quality
