class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    return if name == 'Blue Distinction Plus'

    if name == 'Blue First'
      update_blue_first
    elsif name == 'Blue Compare'
      update_blue_compare
    else
      update_normal
    end

    self.expires_in -= 1 unless name == 'Blue Distinction Plus'
    self.quality = [quality, 0].max
    self.quality = [quality, 50].min unless name == 'Blue Distinction Plus'
  end

  private

  def update_blue_first
    return if quality >= 50

    self.quality += 1
    self.quality += 1 if expires_in <= 0
  end

  def update_blue_compare
    return self.quality = 0 if expires_in <= 0

    quality_increase = 1
    quality_increase += 1 if expires_in <= 10
    quality_increase += 1 if expires_in <= 5
    self.quality += quality_increase
  end

  def update_normal
    return if quality <= 0

    quality_degrade = expires_in <= 0 ? 2 : 1
    quality_degrade *= 2 if name == 'Blue Star'
    self.quality -= quality_degrade
  end
end
