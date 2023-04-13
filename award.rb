# frozen_string_literal: true

# Award class
class Award
  attr_accessor :name, :expires_in, :quality

  AWARDS = ['Blue Compare', 'Blue First', 'Blue Distinction Plus', 'Blue Star'].freeze

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    return update unless AWARDS.include?(@name)

    Object.const_get(@name.delete(' ')).new(self).update
  end

  def update
    @quality -= 1 if @quality.positive?
    @expires_in -= 1
    @quality -= 1 if @expires_in <= 0 && @quality.positive?
  end
end

# blue_compare class
class BlueCompare
  def initialize(award)
    @award = award
  end

  def update
    if @award.expires_in <= 0
      @award.quality = 0
    elsif @award.expires_in <= 5
      @award.quality += 3
    elsif @award.expires_in <= 10
      @award.quality += 2
    else
      @award.quality += 1
    end

    @award.quality = 50 if @award.quality > 50
    @award.expires_in -= 1
  end
end

# blue_first class
class BlueFirst
  def initialize(award)
    @award = award
  end

  def update
    @award.quality += @award.expires_in.positive? ? 1 : 2
    @award.quality = 50 if @award.quality > 50
    @award.expires_in -= 1
  end
end

# blue_distinction_plus class
class BlueDistinctionPlus
  def initialize(award)
    @award = award
  end

  def update
    @award
  end
end

# blue_star class
class BlueStar
  def initialize(award)
    @award = award
  end

  def update
    @award.quality -= 2 if @award.quality.positive?
    @award.expires_in -= 1
    @award.quality -= 2 if @award.expires_in <= 0 && @award.quality.positive?
  end
end
