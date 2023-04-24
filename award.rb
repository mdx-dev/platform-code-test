class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    self.name = name
    self.expires_in = expires_in
    self.quality = quality
  end
end
