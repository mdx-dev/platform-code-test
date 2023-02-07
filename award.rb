class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    case name
    when 'Blue Distinction Plus'
      self.quality = 80
    when 'Blue Compare'
      update_blue_compare_quality
    when 'Blue First'
      update_blue_first_quality
    when 'Blue Star'
      update_blue_star_quality
    else
      if expires_in <= 0
	      self.quality = [quality - 2, 0].max
	    else
	      self.quality = [quality - 1, 0].max
	    end
    end

    self.expires_in -= 1 unless name == 'Blue Distinction Plus'
  end

  private

  def update_blue_compare_quality
    if expires_in <= 0
      self.quality = 0
    elsif expires_in <= 5
      self.quality = [quality + 3, 50].min
    elsif expires_in <= 10
      self.quality = [quality + 2, 50].min
    else
      self.quality = [quality + 1, 50].min
    end
  end

  def update_blue_first_quality
    if expires_in <= 0
      self.quality = [quality + 2, 50].min
    else
      self.quality = [quality + 1, 50].min
    end
  end

  def update_blue_star_quality
    if expires_in <= 0
      self.quality = [quality - 4, 0].max
    else
      self.quality = [quality - 2, 0].max
    end
  end
end
