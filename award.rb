Award = Struct.new(:name, :expires_in, :quality) do |new_class|
  def increase_quality(quality)
    self.quality += quality
  end

  def decrease_quality(quality)
    self.quality -= quality
  end
end
