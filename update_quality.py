import math

# Changes:
# Broke the logic out in to three section - the initial quality pass, updating the expirations, and then quality for expired items.
# Using the math library to reduce the indentation with all the 'if' blocks, and allow for better management of changes beyond +/- 1
# Flipped all the != conditions around to == conditions so they are easier for me to read

# Manage the first pass of quality changes
def update_quality_before_expiration(award):
    # Blue First grows in quality over time
    if award.name == 'Blue First':
        award.quality = min(award.quality + 1, 50)

    # Blue compare grows in quality, increasing as it gets closer to expiration
    elif award.name == 'Blue Compare':
        if award.expires_in < 6:
            award.quality = min(award.quality + 3, 50)
        elif award.expires_in < 11:
            award.quality = min(award.quality + 2, 50)
        else:
            award.quality = min(award.quality + 1, 50)

    # Blue Distinction Plus does not change quality
    elif award.name == 'Blue Distinction Plus':
        pass

    # # Blue Star awards should lose quality value twice as fast as normal awards.
    elif award.name == 'Blue Star':
        award.quality = max(award.quality - 2, 0)

    # Everything else gets reduced by 1, down to a minimum of zero
    else:
        award.quality = max(award.quality - 1, 0)


# Handle changing expiration dates - Only one special condition at the moment
def update_expiration(award):
    if award.name == 'Blue Distinction Plus':
        # Blue Distinction Plus does not expire
        pass
    else:
        award.expires_in -= 1


# def update_expired_awards(award):

def update_expired_awards(award):
    # Blue Distinction Plus does not reduce in quality
    if award.name == 'Blue Distinction Plus':
        pass

    # Blue First gains quality post-expiration, up to a max of 50
    elif award.name == 'Blue First':
        award.quality = min(award.quality + 1, 50)
    
    # Blue Compare quality goes to 0 when it expires
    elif award.name == 'Blue Compare':
        award.quality = 0

    # Blue Star reduces at double the rate of normal awards
    elif award.name == 'Blue Star':
        award.quality = max(award.quality - 2, 0)

    # Everything else gets reduced by 1 down to a minimum of zero
    else:
        award.quality = max(award.quality - 1, 0)


# Updates the quality of the given awards based on their current quality, type, and age.
def update_quality(awards):
    for award in awards:

        # First pass at quality updates
        update_quality_before_expiration(award)

        # Update expirations
        update_expiration(award)

        # Handle already-expired awards
        if award.expires_in < 0:
            update_expired_awards(award)
