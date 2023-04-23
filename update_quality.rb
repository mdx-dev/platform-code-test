require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'NORMAL ITEM'
      update_normal_quality(award)
    when 'Blue First'
      update_blue_first_quality(award)
    when 'Blue Distinction Plus'
      update_blue_distinction_plus_quality(award)
    when 'Blue Compare'
      update_blue_compare_quality(award)
    when 'Blue Star'
      update_blue_star_quality(award)
    end
  end
end

def update_normal_quality(award)
  award.expires_in -= 1
  return if award.quality.zero?

  award.quality -= 1
  award.quality -= 1 if award.expires_in <= 0
end

def update_blue_first_quality(award)
  award.expires_in -= 1
  return if award.quality >= 50

  award.quality += 1
  award.quality += 1 if award.expires_in <= 0
end

def update_blue_distinction_plus_quality(award); end

def update_blue_compare_quality(award)
  award.expires_in -= 1
  return if award.quality >= 50
  return award.quality = 0 if award.expires_in.negative?

  award.quality += 1
  award.quality += 1 if award.expires_in < 10
  award.quality += 1 if award.expires_in < 5
end

def update_blue_star_quality(award)
  award.expires_in -= 1
  return if award.quality.zero?

  award.quality -= 2
  award.quality -= 2 if award.expires_in <= 0
end