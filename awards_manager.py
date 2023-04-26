class AwardsManager:
    def __init__(self, awards):
        self.awards = awards

    def update_quality(self):
        for award in self.awards:
            if award.name != 'Blue Distinction Plus':
                if award.name == 'Blue Compare':
                    self.blue_compare(award)
                elif award.name == 'Blue First':
                    self.blue_first(award)
                elif award.name == 'Blue Star':
                    self.blue_star(award)
                else:
                    self.normal_award(award)
                award.expires_in -= 1


    def normal_award(self, award):
        if award.quality > 0:
            if award.expires_in > 0:
                award.quality -= 1
            elif award.expires_in <= 0:
                award.quality -= 2

        if award.quality < 0:
            award.quality = 0


    def blue_first(self, award):
        if award.quality < 50:
            if award.expires_in > 0:
                award.quality += 1
            elif award.expires_in <= 0:
                award.quality += 2

        if award.quality > 50:
            award.quality = 50


    def blue_compare(self, award):
        if award.quality < 50:
            if award.expires_in > 10:
                award.quality += 1
            elif 5 < award.expires_in <= 10:
                award.quality += 2
            elif 0 < award.expires_in <= 5:
                award.quality += 3
            else:
                award.quality = 0

        if award.quality > 50:
            award.quality = 50


    def blue_star(self, award):
        if award.expires_in > 0 and award.quality > 0:
            award.quality -= 2
        elif award.expires_in <= 0 and award.quality > 0:
            award.quality -= 4

        if award.quality < 0:
            award.quality = 0
