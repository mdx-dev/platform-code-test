require 'award'

def update_quality(awards)
  awards.each do |award|
    
    # NORMAL ITEM    
    if award.name == 'NORMAL ITEM'
      award.expires_in -= 1
      return if award.quality == 0
      
      award.quality -= 1
      award.quality -= 1 if award.expires_in <= 0
    end

    # BLUE FIRST
    if award.name == 'Blue First'
      award.expires_in -= 1
      return if award.quality == 50
      
      award.quality += 1
      award.quality += 1 if award.expires_in <= 0 && award.quality < 50
    end

    # BLUE COMPARE
    if award.name == 'Blue Compare'
      award.expires_in -= 1
      return if award.quality >= 50
      return award.quality = 0 if award.expires_in < 0

      award.quality += 1
      award.quality += 1 if award.expires_in < 10 && award.quality < 50
      award.quality += 1 if award.expires_in < 5 && award.quality < 50
    end

    # BLUE STAR
    if award.name == 'Blue Star'
      award.expires_in -= 1
      return if award.quality == 0

      award.quality -= 2
      award.quality -= 2 if award.expires_in <= 0
    end

  end
end
