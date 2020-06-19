require 'award'

def update_quality(awards)
  awards.each do |award|
    next if award.name == 'Blue Distinction Plus'

    if ['Blue First', 'Blue Compare'].include?(award.name)
      award.increment_quality
    else
      award.decrement_quality
    end

    award.expires_in -= 1
    award.handle_expired if !award.active?
  end
end
