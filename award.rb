Award = Struct.new(:name, :expires_in, :quality) do

  def blue_first
    self.quality += 1 if self.quality < 50
    self.expires_in -= 1
    self.quality +=1 if self.expires_in <= 0 && self.quality < 50
  end

  def blue_compare
    if self.quality < 50
      self.quality += 1
      self.quality += 1 if self.expires_in < 11 && self.quality < 50
      self.quality += 1 if self.expires_in < 6 && self.quality < 50
    end

    self.expires_in -= 1
    self.quality = 0 if self.expires_in < 0 
  end

  def blue_star
    self.quality -= 2 if self.quality > 0
    self.expires_in -= 1
    self.quality -= 2 if self.expires_in < 0 && self.quality > 0
  end

  def normal_item
    self.quality -= 1 if self.quality > 0
    self.expires_in -= 1
    self.quality -= 1 if self.expires_in < 0 && self.quality > 0
  end

end