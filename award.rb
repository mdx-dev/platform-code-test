require 'pry'

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, initial_expires_in, initial_quality)
    @name = name
    @expires_in = initial_expires_in
    @quality = initial_quality
  end

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

  def quality_greater_than_zero?
    @quality > 0
  end

  def expired?
    @expires_in <= 0
  end

  def max_quality?
    if @quality >= 50
      @quality = 50
      return true
    end
    false
  end

  def update_normal
    @quality -= 1 if quality_greater_than_zero?
    @expires_in -= 1
    @quality -= 1 if expired? && quality_greater_than_zero?
  end

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
  
  def update_blue_first
    if  !expired?
      @quality += 1
    else
      @quality += 2
    end
    max_quality?
    @expires_in -= 1
  end

  # distinction plus doesn't change quality
  def update_distinction_plus
    self
  end

  def update_blue_star
    self
  end

end