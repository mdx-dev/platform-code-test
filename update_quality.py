# mharb
# TODO un-nest loops for performance
# TODO Which is faster? switches or elifs?
# TODO Branch script into increasing and decreasing for performance (if or while)
# TODO fix 'Blue First' bug

'''Naive function that passes all tests and meets business requirements'''


def update_quality(awards):
    '''Refresh award quality according to expiration date and award quirks'''
    for award in awards:
        # Expired awards decay faster
        if award.expires_in < 1:
            decay_mult = 2
        else:
            decay_mult = 1
        # This award has static quality
        if award.name == "Blue Distinction Plus":
            award.quality = 80
            break
        # Refresh decreasing qualities
        if bool(award.quality):
            match award.name:
                case "NORMAL ITEM":
                    award.quality -= decay_mult
                case "Blue Star":
                    award.quality -= (2 * decay_mult)
        # Refresh increasing qualities
        if award.quality < 50:
            match award.name:
                case "Blue Compare":
                    if award.expires_in in range(1, 6):
                        award.quality += 3
                    elif award.expires_in in range(6, 11):
                        award.quality += 2
                    elif award.expires_in > 10:
                        award.quality += 1
                    else:
                        award.quality = 0
                case "Blue First":
                    # BUG: if statement to handle odd input; please fix!
                    if award.quality == 49:
                        award.quality += 1
                    else:
                        award.quality += decay_mult
        # Step forward
        award.expires_in -= 1
