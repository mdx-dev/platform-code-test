class Award
  attr_reader :name
  attr_accessor :expires_in,
                :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end
end
