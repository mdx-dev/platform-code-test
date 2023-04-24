class Award
  attr_reader :quality
  attr_accessor :name, :expires_in

  def initialize(name, expires_in, quality)
    self.name = name
    self.expires_in = expires_in
    self.quality = quality
  end

  def quality=(quality)
    if self.name.eql? 'Blue Distinction Plus'
      @quality = 80
      return
    end

    # quality can never be negative
    if quality < 0
      @quality = 0 
      return
    end

    #quality can never be more than 50
    if quality > 50
      @quality = 50
      return
    end

    @quality = quality
  end

  def decrement_expires_in(amount=1)
    return if self.name.eql? 'Blue Distinction Plus'
    self.expires_in -= amount
  end
end
