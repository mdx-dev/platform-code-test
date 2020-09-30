# Award = Struct.new(:name, :expires_in, :quality)

class Award
  attr_accessor :name, :expires_in


  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def quality
    @quality
  end

  def quality=(new_quality)
    @quality = new_quality
    @quality = @quality.clamp(0,50)
  end

  # def quality=(new_quality)
  #   @quality = new_quality
  # end
end
