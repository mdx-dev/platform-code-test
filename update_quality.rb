require 'award'

# Changes:
# Broke the logic out in to three section - the initial quality pass, updating the expirations, and then quality for expired items.
# Using the .max and .min to reduce the indentation with all the 'if' blocks, and allow for better management of changes beyond +/- 1
# Flipped all the != conditions around to == conditions so they are easier for me to read

# Manage the first pass of quality changes
def update_quality_before_expiration(award)
  # Blue First grows in quality over time
  if award.name == 'Blue First'
    award.quality = [award.quality + 1, 50].min
  
  # Blue compare grows in quality, increasing as it gets closer to expiration
  elsif award.name == 'Blue Compare'
    if award.expires_in < 6
      award.quality = [award.quality + 3, 50].min
    elsif award.expires_in < 11
      award.quality = [award.quality + 2, 50].min
    else
      award.quality = [award.quality + 1, 50].min
    end


  # Blue Distinction Plus does not change quality
  elsif award.name == 'Blue Distinction Plus'
    # Do nothing


  # Blue Star awards should lose quality value twice as fast as normal awards.
  elsif award.name == 'Blue Star'
    award.quality = [award.quality - 2, 0].max


  # Everything else gets reduced by 1, down to a minimum of zero
  else
    award.quality = [award.quality - 1, 0].max

  end
end



# Handle changing expiration dates - Only one special condition at the moment
def update_expiration(award)
  # Blue Distinction Plus does not expire
  if award.name == 'Blue Distinction Plus'
    # Do nothing
  else
    award.expires_in -= 1
  end
end


# Handle the quality changes for just expired awards
def update_expired_awards(award)
  # Blue Distinction Plus does not reduce in quality
  if award.name == 'Blue Distinction Plus'
      # Do nothing

  # Blue First gains quality post-expiration, up to a max of 50
  elsif award.name == 'Blue First'
      award.quality = [award.quality + 1, 50].min
  
  # Blue Compare quality goes to 0 when it expires
  elsif award.name == 'Blue Compare'
      award.quality = 0

  # Blue Star reduces at double the rate of normal awards
  elsif award.name == 'Blue Star'
      award.quality = [award.quality - 2, 0].max

  # Everything else gets reduced by 1 down to a minimum of zero
  else
      award.quality = [award.quality - 1, 0].max

  end
end

# Updates the quality of the given awards based on their current quality, type, and age.
def update_quality(awards)
  awards.each do |award|

    # First pass at quality updates
    update_quality_before_expiration(award)

    # Update expirations
    update_expiration(award)

    # Handle already-expired awards
    if award.expires_in < 0
        update_expired_awards(award)
    end

  end
end
