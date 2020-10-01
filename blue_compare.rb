class BlueCompare < Award
  def update_quality
    case expires_in
    when -Float::INFINITY..0
      self.quality = 0
    when 1..5
      self.quality += 3
    when 6..10
      self.quality += 2
    else
      self.quality += 1
    end

    update_expires_in
  end
end
