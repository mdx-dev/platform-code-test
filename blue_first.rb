class BlueFirst < Award
  def update_quality
    if expires_in > 0
      self.quality += 1
    else
      self.quality += 2
    end

    update_expires_in
  end
end
