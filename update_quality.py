from award import Award


def depreciate_quality(award: Award) -> None:
    if award.name == "Blue Star":
        award.quality -= 1


def update_quality(awards):
    for award in awards:
        if award.name != "Blue First" and award.name != "Blue Compare":
            if award.quality > 0:
                if award.name != "Blue Distinction Plus":
                    award.quality -= 1
                depreciate_quality(award)
        else:
            if award.quality < 50:
                award.quality += 1
                if award.name == "Blue Compare":
                    if award.expires_in <= 10:
                        if award.quality < 50:
                            award.quality += 1
                    if award.expires_in <= 5:
                        if award.quality < 50:
                            award.quality += 1

        if award.name != "Blue Distinction Plus":
            award.expires_in -= 1

        if award.expires_in < 0:
            if award.name != "Blue First":
                if award.name != "Blue Compare":
                    if award.quality > 0:
                        if award.name != "Blue Distinction Plus":
                            award.quality -= 1
                        depreciate_quality(award)
                else:
                    award.quality = award.quality - award.quality
            else:
                if award.quality < 50:
                    award.quality += 1
