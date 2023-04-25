class AwardManager
  attr_accessor :award

  def initialize(award)
    @award = award
  end

  def update_quality
    unless award.name == 'Blue Distinction Plus'
      case award.name
      when 'Blue Compare'
        blue_compare
      when 'Blue First'
        blue_first
      when 'Blue Star'
        blue_star
      else
        normal_award
      end
      award.expires_in -= 1
    end

  end

  private
  # quality score degrades by 1 before the expiration
  # quality score degrades by 2 after the expiration
  # quality can't be less than 0

  def normal_award
    if award.quality > 0
      if award.expires_in > 0
        award.quality -= 1
      elsif award.expires_in <= 0
        award.quality -= 2
      end
    end

    award.quality = 0 if award.quality < 0
  end

  # quality increases by 1 before expiration
  # quality increases by 2 on the day of expiration and after
  # quality can't be greater than 50
  
  def blue_first
    if award.quality < 50
      if award.expires_in > 0
        award.quality += 1
      elsif award.expires_in <= 0
        award.quality += 2
      end
    end

    award.quality = 50 if award.quality > 50
  end

  # quality increases by 1 before 10 days of expiration
  # quality increases by 2 when expires_in <= 10
  # quality increases by 3 when expires_in <= 5
  # quality = 0 when expires_in <= 0

  def blue_compare
    if award.quality < 50
      if award.expires_in > 10
        award.quality += 1
      elsif award.expires_in <= 10 && award.expires_in > 5
        award.quality += 2
      elsif award.expires_in <= 5 && award.expires_in > 0
        award.quality += 3
      else
        award.quality = 0
      end
    end

    award.quality = 50 if award.quality > 50
  end

  # quality degrades by 2 before the expiration
  # quality degrades by 4 after the expiration

  def blue_star
    if award.expires_in > 0 && award.quality > 0
      award.quality -= 2
    elsif award.expires_in <= 0 && award.quality > 0
      award.quality -= 4
    end

    award.quality = 0 if award.quality < 0
  end
end