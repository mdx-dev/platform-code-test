class BlueStar < Award
  def update_quality
    if expires_in > 0
      self.quality -= 2
    else
      self.quality -= 4
    end

    update_expires_in
  end
end
