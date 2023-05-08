require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      blue_first(award)
      expire_decay(award)

    when 'Blue Compare'
      blue_compare(award)
      expire_decay(award)
    
    when 'Blue Distinction Plus'
      blue_dist_plus(award)
    
    when 'Blue Star'
      blue_star(award)
      expire_decay(award)
    
    else 
      normal_award(award)
      expire_decay(award)   
    end

    check_quality_upper(award)
    check_quality_lower(award)
  end
end

def check_quality_upper(award)
  award.quality = 50 if award.quality > 50 and award.name != 'Blue Distinction Plus'
end

def check_quality_lower(award)
  award.quality = 0 if award.quality < 0
end

def expire_decay(award)
  award.expires_in -= 1
end

def normal_award(award)
  award.quality -= 1
  award.quality -= 1 if award.expires_in <= 0
end

def blue_first(award)
  award.quality += 1
  award.quality += 1 if award.expires_in <= 0
end

def blue_compare(award)
  award.quality += 1
  award.quality += 1 if award.expires_in < 11
  award.quality += 1 if award.expires_in < 6
  award.quality = award.quality - award.quality if award.expires_in <= 0
end

def blue_dist_plus(award)
  award.quality = 80
end

def blue_star(award)
  award.quality -= 2
  award.quality -= 2 if award.expires_in <= 0
end
