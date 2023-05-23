require 'award'

class RewardModifier
  attr_accessor :awards
  WHITE_LIST = ['Blue First', 'Blue Compare', 'Blue Distinction Plus']
  def initialize(awards)
    @awards = awards
  end

  def update_quality
    awards.each do |award|
      calculate_quality(award)
      modify_expiration_date(award)
      calculate_expired_quality(award) if expiration_passed?(award)
    end
  end

  def modify_expiration_date(award)
    award.decrease_expiration(1) if award.name != 'Blue Distinction Plus'
  end

  def calculate_quality(award)
    case award.name
    when *WHITE_LIST
      award.increase_quality(1) if award.quality < 50
      if award.name == 'Blue Compare'
        award.increase_quality(1) if award.expires_in < 11 && award.quality < 50
        award.increase_quality(1) if award.expires_in < 6 && award.quality < 50
      end
    else
      if !award.quality.zero? && award.name != 'Blue Star'
        award.decrease_quality(1)
      elsif !award.quality.zero? && award.name == 'Blue Star'
        award.decrease_quality(2)
      end
    end
  end

  def expiration_passed?(award)
    award.expires_in < 0
  end

  def calculate_expired_quality(award)
    unless award.name == 'Blue First'
      if award.name != 'Blue Compare'
        award.decrease_quality(1) if award.name != 'Blue Distinction Plus' && award.quality > 0 && award.name != 'Blue Star'
        award.decrease_quality(2) if award.name == 'Blue Star' && award.quality > 0
      else
        award.quality = 0
      end
    end

    award.increase_quality(1) if award.name == 'Blue First' && award.quality < 50
  end
end
