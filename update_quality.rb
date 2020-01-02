require 'award'

# Blue First increases quality over time
def update_blue_first(award)
  award.quality += 1
  # Quality doubles after expiration (according to tests)
  award.quality += 1 if award.expires_in <= 0
end

# Blue Distinction Plus Quality never degrades, initializes and stays @ 80
def update_blue_distinction_plus(award)
  award.quality = 80
end

# "Blue Compare" increases as expiration approaches
#   expires <= 10 && > 5
#   expires <= 5 && > 0
#   quality == 0 after expiration date
def update_blue_compare(award)
  if award.expires_in > 0
    award.quality += 1
    award.quality += 1 if award.expires_in < 11
    award.quality += 1 if award.expires_in < 6
  else
    award.quality = 0
  end
end

# Blue Star degrades twice as fast as a normal award
def update_blue_star(award)
  update_normal(award)
  update_normal(award)
end

def update_normal(award)
  award.quality -= 1
  # Award degrades twice as fast after expiration
  award.quality -= 1 if award.expires_in <= 0
end

def enforce_quality_limits(award)
  return if award.name == 'Blue Distinction Plus'

  award.quality = 50 if award.quality > 50
  award.quality = 0 if award.quality < 0
end

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue Compare'
      update_blue_compare(award)
    when 'Blue First'
      update_blue_first(award)
    when 'Blue Distinction Plus'
      update_blue_distinction_plus(award)
    when 'Blue Star'
      update_blue_star(award)
    else
      update_normal(award)
    end

    enforce_quality_limits(award)

    award.expires_in -= 1
  end
end
