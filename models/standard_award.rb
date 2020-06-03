class StandardAward
    attr_accessor :name, :expires_in, :quality

    def initialize(name, expires_in, quality)
      @name = name
      @expires_in = expires_in
      @quality = quality
    end

    def update_quality
      if @expires_in > 0
        decrement_quality
      else
        decrement_quality
        decrement_quality
      end
      decrement_expiry
    end

    def decrement_quality
      if @quality > 0
        @quality -= 1
      end
    end

    def increment_quality
      if @quality < 50
        @quality += 1
      end
    end

    def decrement_expiry
      @expires_in -= 1
    end
    # toString method - dev purposes
    def to_s
       "#{self.singleton_class} name: #{@name}, expires_in: #{@expires_in}, quality: #{@quality}"
    end
end
