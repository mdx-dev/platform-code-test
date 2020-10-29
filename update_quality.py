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
                #  Blue Star award depreciates in quality value twice as fast as normal awards before expiration date
                depreciate_quality(award)
        else:
            if award.quality < 50:
                award.quality += 1
                if award.name == "Blue Compare":
                    # changed from less than 11 to less than or equal 10, because readme specified
                    # that the quality increases by 2 when there are 10 days or less left
                    if award.expires_in <= 10:
                        if award.quality < 50:
                            award.quality += 1
                    # changed from less than 11 to less than or equal 10, because readme specified
                    # that the quality increases by 2 when there are 10 days or less left
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
                            #  Blue Star award depreciates in quality value twice as fast as normal awards after expiration date
                            depreciate_quality(award)
                else:
                    award.quality = award.quality - award.quality
            else:
                if award.quality < 50:
                    award.quality += 1
