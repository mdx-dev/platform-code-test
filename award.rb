require 'pry'

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, initial_expires_in, initial_quality)
    @name = name
    @expires_in = initial_expires_in
    @quality = initial_quality
  end

  # update award based on award name
  def handle_award_update
    case @name
    when 'NORMAL ITEM'
      update_normal
    when 'Blue Compare'
      update_blue_compare
    when 'Blue First'
      update_blue_first
    when 'Blue Distinction Plus'
      update_distinction_plus
    when 'Blue Star'
      update_blue_star
    end
  end

  # quality cannot be less than 0
  def quality_greater_than_zero?
    @quality > 0
  end

  def expired?
    @expires_in <= 0
  end

  # @quality cannot exceed 50
  def max_quality?
    if @quality >= 50
      @quality = 50
      return true
    end
    false
  end

  # generic award update
  def update_normal
    @quality -= 1 if quality_greater_than_zero?
    @expires_in -= 1
    @quality -= 1 if expired? && quality_greater_than_zero?
  end

  # @quality increase varies by number of days left before expiration and resets to 0 if expired
  def update_blue_compare
    if expired? 
      @quality = 0
    elsif @expires_in <= 5
      @quality += 3
    elsif @expires_in <= 10
      @quality += 2
    else
      @quality += 1
    end
    max_quality?
    @expires_in -= 1
  end
  
  #increase by one if not expired, otherwise @quality increases by 2
  def update_blue_first
    if  !expired?
      @quality += 1
    else
      @quality += 2
    end
    max_quality?
    @expires_in -= 1
  end

  # distinction plus doesn't change quality so just return award
  def update_distinction_plus
    self
  end

  # @quality of Blue star degrades twice as fast as normal awards
  def update_blue_star
    @quality -= 2 if quality_greater_than_zero?
    @quality -= 2 if expired? && quality_greater_than_zero?
    @expires_in -= 1
  end

end