def update_quality(awards):
    for award in awards:
        if award.name != "Blue First" and award.name != "Blue Compare":
            if award.quality > 0:
                if award.name != "Blue Distinction Plus":
                    if award.name == "Blue Star":
                        award.quality -= 2
                    else:
                        award.quality -= 1
        else:
            if award.quality < 50:
                award.quality += 1
                if award.name == "Blue Compare":
                    if award.expires_in < 11:
                        if award.quality < 50:
                            award.quality += 1
                    if award.expires_in < 6:
                        if award.quality < 50:
                            award.quality += 1

        if award.name != "Blue Distinction Plus":
            award.expires_in -= 1

        if award.expires_in < 0:
            if award.name != "Blue First":
                if award.name != "Blue Compare":
                    print("award is blue star on expiration day")
                    if award.quality > 0:
                        if award.name != "Blue Distinction Plus":
                            if award.name == "Blue Star":
                                award.quality -= 2
                            else:
                                award.quality -= 1
                else:
                    award.quality = award.quality - award.quality
            else:
                if award.quality < 50:
                    award.quality += 1
