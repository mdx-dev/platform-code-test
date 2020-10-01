class BlueStar < Award
  def update_quality
    if expires_in > 0
      if quality > 0
        self.quality -= 2
      end
    else
      self.quality -= 4
    end

    update_expires_in
  end
end
