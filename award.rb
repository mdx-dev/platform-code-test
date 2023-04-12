require 'award_system'

class Award
  attr_reader :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
    @min_quality = 0
    @max_quality = 50
    @decrements = true
    validate
  end

  def calculate
    case @name
    when 'NORMAL ITEM' then normal_item
    when 'Blue First' then blue_first
    when 'Blue Distinction Plus' then blue_distinction_plus
    when 'Blue Compare' then blue_compare
    when 'Blue Star' then blue_star
    end

    enforce_min_max
    decrement_expires_in if @decrements
  end

  private

  def validate
    unless AwardSystem::AWARD_NAMES.include?(@name)
      raise ArgumentError.new("Award name must be one of: #{AwardSystem::AWARD_NAMES}")
    end
  end

  def normal_item
    if @expires_in > 0
      @quality -= 1
    else
      @quality -= 2
    end
  end

  def blue_first
    if @expires_in > 0
      @quality += 1
    else
      @quality += 2
    end
  end

  def blue_distinction_plus
    @decrements = false
    @max_quality = 80
  end

  def blue_compare
    case @expires_in
    when 11..Float::INFINITY then @quality += 1
    when 6..10 then @quality += 2
    when 1..5 then @quality += 3
    when 0 then @quality = 0
    when -Float::INFINITY..-1 then @quality = 0
    end
  end

  def blue_star
    if @expires_in > 0
      @quality -= 2
    elsif @expires_in <= 0
      @quality -= 4
    end
  end

  def decrement_expires_in
    @expires_in -= 1
  end

  def enforce_min_max
    @quality = @min_quality if @min_quality && @quality < @min_quality
    @quality = @max_quality if @max_quality && @quality > @max_quality
  end
end