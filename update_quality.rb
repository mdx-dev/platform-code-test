require 'award'

METHOD_MAP = {
  'Blue First' => :update_blue_first_award,
  'Blue Compare' => :update_blue_compare_award,
  'Blue Star' => :update_blue_star_award,
  'Blue Distinction Plus' => :update_blue_distinction_plus_award,
}.freeze

def update_quality(awards)
  awards.each do |award|
    return if award.name == 'Blue Distinction Plus'

    award.expires_in -= 1

    send METHOD_MAP.fetch(award.name, :update_normal_award), award

    award.quality = 0 if award.quality < 0
    award.quality = 50 if award.quality > 50
  end
end

def update_normal_award(award)
  if award.expires_in > 0
    award.quality -= 1
  else
    award.quality -= 2
  end
end

def update_blue_star_award(award)
  if award.expires_in > 0
    award.quality -= 2
  else
    award.quality -= 4
  end
end

def update_blue_first_award(award)
  if award.expires_in > 0
    award.quality += 1
  else
    award.quality += 2
  end
end

def update_blue_compare_award(award)
  if award.expires_in >= 0
    award.quality += 1
    award.quality += 1 if award.expires_in < 10
    award.quality += 1 if award.expires_in < 5
  else
    award.quality = 0
  end
end
