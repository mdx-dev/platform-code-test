def update_quality(awards):
    for award in awards:
        #UserStory: Handle Blue Star Award seperately
        if award.name != 'Blue First' and award.name != 'Blue Compare' and award.name != 'Blue Star': 
            if award.quality > 0:
                if award.name != 'Blue Distinction Plus':
                    award.quality -= 1
        else:
            if award.name != 'Blue Star':
                if award.quality < 50:
                    award.quality += 1
                    if award.name == 'Blue Compare':
                        if award.expires_in < 11:
                            if award.quality < 50:
                                award.quality += 1
                        if award.expires_in < 6:
                            if award.quality < 50:
                                award.quality += 1

        if award.name != 'Blue Distinction Plus':
            award.expires_in -= 1

        if award.expires_in < 0:
            if award.name != 'Blue First':
                if award.name != 'Blue Compare':
                    if award.quality > 0:
                        if award.name != 'Blue Distinction Plus' and award.name != 'Blue Star':
                            award.quality -= 1
                else:
                    award.quality = award.quality - award.quality
            else:   
                if award.name != 'Blue Star':
                    if award.quality < 50:
                        award.quality += 1
        #UserStory: Handle Blue Star Award seperately here to lose quality value twice as fast as normal awards. 
        if award.name == 'Blue Star':
            if award.quality > 1:
                if award.expires_in > 0:
                    award.quality -= 2
                else:
                    award.quality -= 4
            if award.quality < 0:  #Handle quality to not make negative during calculation
                award.quality = 0


