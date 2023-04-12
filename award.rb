require 'award_system'

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality

    validate
  end

  def calculate
    case @name
    when 'NORMAL ITEM' then normal_item
    when 'Blue First' then blue_first
    when 'Blue Distinction Plus' then blue_distinction_plus
    end
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

    @quality = 0 if @quality < 0
    @expires_in -= 1
  end

  def blue_first
    if @expires_in > 0
      @quality += 1
    else
      @quality += 2
    end

    @quality = 50 if @quality > 50
    @expires_in -= 1
  end

  def blue_distinction_plus
  end
end