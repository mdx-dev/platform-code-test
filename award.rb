# Award = Struct.new(:name, :expires_in, :quality)

class Award

  attr_accessor :name, :expires_in, :quality

  def initialize(name, int_expires_in, int_quality)
    @name = name
    @expires_in = int_expires_in
    @quality = int_quality
  end

  def update_award
    case @name
    when 'Blue Compare'
      update_blue_compare
    when 'Blue Distinction Plus'
      update_blue_distinction_plus
    when 'Blue First'
      update_blue_first
    when 'Blue Star'
      update_blue_star
    when 'NORMAL ITEM'
      update_normal_item
    end
  end

  private

  def expired?
    @expires_in <= 0
  end

  def max_quality?
    if @quality >= 50
      @quality = 50
      return true
    else
      return false
    end
  end

  def quality_larger_than_zero?
    @quality > 0
  end

  def update_blue_compare
    if expired?
      @quality = 0
    elsif @expires_in <= 5
      @quality = @quality + 3
    elsif @expires_in <= 10
      @quality = @quality + 2
    else
      @quality = @quality + 1
    end
    max_quality?
    @expires_in = @expires_in - 1
  end

  def update_blue_distinction_plus
    @quality = 80
  end

  def update_blue_first
    if !expired?
      @quality = @quality + 1
    else
      @quality = @quality + 2
    end
    max_quality?
    @expires_in = @expires_in - 1
  end

  def update_blue_star
    if quality_larger_than_zero?
      @quality = @quality - 2
    end
    @expires_in = @expires_in - 1
    if expired? && quality_larger_than_zero?
      @quality = @quality - 2
    end
  end

  def update_normal_item
    if quality_larger_than_zero?
      @quality = @quality - 1
    end
    @expires_in = expires_in - 1
    if expired? && quality_larger_than_zero?
      @quality = @quality - 1
    end
  end

end

