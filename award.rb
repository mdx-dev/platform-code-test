
class Award 

    attr_accessor :name, :expires_in, :quality

    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality    
    end

    def update_quality
        @quality -= @expires_in > 0 ? 1 : 2
        @quality = 0 if @quality < 0
        update_expires_in
    end

    def update_expires_in
        @expires_in -= 1
    end

end
