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

class QUpdaterBlueCompare(QUpdaterBlueFirst):
    # Inherits QUpdaterBlueFirst Class
    """
    Blue Compare Item
    """
    def update(self, exp, q):
        # First increase quality is still under 50
        q = (q + 1) if q < 50 else q
        # Second increase expiration days under 10
        q = (q + 1) if (exp < 11 and q < 50) else q
        # Third increase expiration days under 5
        q = (q + 1) if (exp < 6 and q < 50) else q
        exp -= 1
        # 0 if expiration date has passed
        q = 0 if exp < 0 else q
        return exp, q

class QUpdaterBlueDistinctionPlus(QUpdaterBase):
    # Inherits QUpdaterBase class
    """
    Blue Distinction Plus
    """
    def update(self, exp, q):
        # Doesn't update anything! 
        return exp, q

class QUpdaterBlueStar(QUpdaterBase):
    # Inherits QUpdaterBase class
    """
    Blue Star Item
    """
    def update(self, exp, q):
        exp -= 1
        # First decrease(2x) if quality is positive
        q = (q - 2) if q > 0 else q
        # Second decrease(2x) if expiration is passed
        q = (q - 2) if (exp < 0 and q > 0) else q
        return exp, q

# A dictionary linking names with specific classes of quality updaters
updaters = {
    'NORMAL ITEM': QUpdaterBase(),
    'Blue First': QUpdaterBlueFirst(),
    'Blue Compare': QUpdaterBlueCompare(),
    'Blue Distinction Plus': QUpdaterBlueDistinctionPlus(),
    'Blue Star': QUpdaterBlueStar(),
}


class Award(object):
    def __init__(self, name=None, expires_in=None, quality=None):
        self.name = name
        self.expires_in = expires_in
        self.quality = quality
