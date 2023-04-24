class Award
  attr_reader :quality
  attr_accessor :name, :expires_in

  def initialize(name, expires_in, quality)
    self.name = name
    self.expires_in = expires_in
    self.quality = quality
  end

  def quality=(quality)
    @quality = quality.positive? ? quality : 0
  end

  def decrement_expires_in(amount=1)
    return if self.name.eql? 'Blue Distinction Plus'
    self.expires_in -= amount
  end
end
