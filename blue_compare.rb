class BlueCompare < Award
  def update_quality
    if expires_in <= 0
      self.quality = 0
    elsif expires_in <= 5
      self.quality += 3
    elsif expires_in <= 10
      self.quality += 2
    else
      self.quality += 1
    end

    update_expires_in
  end
end
