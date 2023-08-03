require 'award'

class AwardUpdate
  def initialize(award)
    @award = award
  end
  
  protected

  def increase_quality(value)
    @award.quality += value
    @award.quality = 50 if @award.quality > 50
  end

  def decrease_quality(value)
    @award.quality -= value
    @award.quality = 0 if @award.quality < 0
  end
end

class BlueFirstUpdate < AwardUpdate
  def update
    @award.expires_in -= 1
    increase_quality(1)
    increase_quality(1) if @award.expires_in < 0
  end
end

class BlueCompareUpdate < AwardUpdate
  def update
    if @award.expires_in > 10
      increase_quality(1)
    elsif @award.expires_in <= 10 && @award.expires_in > 5
      increase_quality(2)
    elsif @award.expires_in <= 5
      increase_quality(3)
    end
    @award.expires_in -= 1
    @award.quality = 0 if @award.expires_in < 0
  end
end

class BlueDistinctionPlusUpdate < AwardUpdate
  def update
    @award.quality = 80
  end
end

class BlueStarUpdate < AwardUpdate
  def update
    if @award.expires_in >= 0
      decrease_quality(2)
    else
      decrease_quality(4)
    end
    @award.expires_in -= 1
  end
end

class NormalUpdate < AwardUpdate
  def update
    @award.expires_in -= 1
    decrease_quality(1)
    decrease_quality(1) if @award.expires_in < 0
  end
end

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      BlueFirstUpdate.new(award).update
    when 'Blue Compare'
      BlueCompareUpdate.new(award).update
    when 'Blue Distinction Plus'
      BlueDistinctionPlusUpdate.new(award).update
    when 'Blue Star'
      BlueStarUpdate.new(award).update
    else
      NormalUpdate.new(award).update
    end
  end
end
