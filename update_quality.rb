# frozen_string_literal: true

require_relative 'award'

# "Blue Distinction Plus" is static at quality of 80 and never changes
def static_blue_distinction_plus_quality(award)
  award.quality = 80
end

# 'Blue First' increases with age
def age_blue_first_quality(award)
  # increase 2 if expired
  if award.expires_in <= 0
    award.quality += 2
  # increase 1 if valid
  else
    award.quality += 1
  end
end

# normal awards decrease with age
def age_normal_quality(award)
  # reduce 2 if expired
  if award.expires_in <= 0
    award.quality -= 2
  # reduce 1 if valid
  else
    award.quality -= 1
  end
end

# 'Blue Star' same as normal but degrades twice as fast
def age_blue_star_quality(award)
  # reduce 4 if expired
  if award.expires_in <= 0
    award.quality -= 4
  # reduce 2 if valid
  else
    award.quality -= 2
  end
end

# 'Blue Compare' increases with age
# then drops to 0 once expired
def age_blue_compare_quality(award)
  # quality to 0 if expired
  if award.expires_in <= 0
    award.quality = 0
  # quality +3 if 5 days to expiring
  elsif award.expires_in <= 5
    award.quality += 3
  # quality +2 if 10 days to expiring
  elsif award.expires_in <= 10
    award.quality += 2
  # quality +1 if more than 10 days to expiring
  else
    award.quality += 1
  end
end

def check_quality_limits(award)
  # 'Blue Distinction Plus' is static
  return if award.name == 'Blue Distinction Plus'

  # make sure 0 <= quality <= 50
  if award.quality.negative?
    award.quality = 0
  elsif award.quality > 50
    award.quality = 50
  end
end

def update_age(award)
  # 'Blue Distinction Plus' is static
  return if award.name == 'Blue Distinction Plus'

  # else reduce exparation date
  award.expires_in -= 1
end

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue Distinction Plus'
      static_blue_distinction_plus_quality(award)
    when 'Blue First'
      age_blue_first_quality(award)
    when 'Blue Star'
      age_blue_star_quality(award)
    when 'Blue Compare'
      age_blue_compare_quality(award)
    else
      age_normal_quality(award)
    end
    # make sure quality limits are enforced
    check_quality_limits(award)
    # age the award
    update_age(award)
  end
end
