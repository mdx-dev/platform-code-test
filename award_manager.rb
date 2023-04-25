class AwardManager
  attr_accessor :award

  def initialise(award)
    @award = award
  end

  def update_quality
    unless award.name === 'Blue Distinction Plus'
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

  def normal_award
    if award.expires_in > 0 && award.quality > 0
      award.quality -= 1
    elsif award.expires_in <= 0 && award.quality > 0
      award.quality -= 2
    end
  end

  def blue_compare
  end

  def blue_first
  end

  def blue_star
  end
end