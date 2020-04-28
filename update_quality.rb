require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      award.update_blue_first_quality
    when 'Blue Compare'
      award.update_blue_compare_quality
    when 'Blue Star'
      award.update_blue_star_quality
    when 'Blue Distinction Plus'
      award.quality = Award.blue_distinction_plus_quality
    else
      award.update_quality
    end
    #excluded blue distinction for this because tests did not want it to be decremented
    award.expires_in -= 1 if !award.is_blue_distinction_plus?
  end
end