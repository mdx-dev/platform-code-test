class PlatformCodeTest:
    MIN_QUALITY_VALUE = 0

    def __init__(self, award):
        self.award = award

    @classmethod
    def get_max_quality_value(cls, award_name):
        if award_name == 'Blue Distinction Plus':
            return 80
        return 50

    def update_quality(self):
        if self.award.name == 'Blue Distinction Plus':
            return
        self.update_expiry_in()
        if self.award.name == 'Blue First':
            self.update_quality_blue_first()
        elif self.award.name == 'Blue Compare':
            self.update_quality_blue_compare()
        elif self.award.name == 'Blue Star':
            self.update_quality_blue_star()
        else:
            self.update_quality_normal()

    def increase_quality_by_one(self):
        self.award.quality += 1

    def is_expires_in_less_than_zero(self):
        return True if self.award.expires_in < 0 else False

    def is_award_quality_greater_than_min_value(self):
        return self.award.quality > self.MIN_QUALITY_VALUE or False

    def is_award_quality_less_than_max_value(self):
        return True if self.award.quality < PlatformCodeTest.get_max_quality_value(self.award.name) else False

    def decrease_quality_by_one(self):
        self.award.quality -= 1

    def update_quality_normal(self):
        if self.is_award_quality_greater_than_min_value():
            self.decrease_quality_by_one()
        if self.is_expires_in_less_than_zero() and self.is_award_quality_greater_than_min_value():
            self.decrease_quality_by_one()

    def update_quality_blue_first(self):
        if self.is_award_quality_less_than_max_value():
            self.increase_quality_by_one()
        if self.is_expires_in_less_than_zero() and self.is_award_quality_less_than_max_value():
            self.increase_quality_by_one()

    def update_quality_blue_compare(self):
        print(self.award.name, self.award.expires_in, self.award.quality)
        if self.is_award_quality_less_than_max_value():
            self.award.quality += 1
        if self.award.expires_in + 1 < 11 and self.is_award_quality_less_than_max_value():
            self.award.quality += 1
        if self.award.expires_in + 1 < 6 and self.is_award_quality_less_than_max_value():
            self.award.quality += 1
        if self.award.expires_in < 0:
            self.award.quality = 0

    def update_quality_blue_star(self):
        def fun():
            for _ in range(0, 2):
                if self.is_award_quality_greater_than_min_value():
                    self.decrease_quality_by_one()
        fun()
        if self.is_expires_in_less_than_zero():
            fun()

    def update_expiry_in(self):
        self.award.expires_in -= 1


def update_quality(awards):
    for award in awards:
        a = PlatformCodeTest(award)
        a.update_quality()
