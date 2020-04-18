
class Award
    attr_reader :maxQuality, :minQuality
    attr_accessor :name, :expires_in, :quality
    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality
        @maxQuality = 50
        @minQuality = 0
    end

  
    def self.all 
        ObjectSpace.each_object(self).to_a
    end 

    def update_quality
        self.quality -=1 if self.quality > minQuality
        self.expires_in -=1 
        self.quality -= 1 if self.expires_in < 0 &&  self.quality > minQuality
    end
    
end


class BlueFirst < Award 

    def update_quality
        self.quality +=1 if self.quality < maxQuality
        self.expires_in -=1 

        self.quality += 1 if self.expires_in < 0 && self.quality < maxQuality
    end

end 

class BlueCompare < Award

    def update_quality
        if self.quality < maxQuality
            self.quality +=1
            self.quality += 1 if self.expires_in < 11
            self.quality += 1 if self.expires_in < 6  
        end

        self.expires_in -=1 

        self.quality = 0 if self.expires_in < 0
    end

end

class BlueDistinctionPlus < Award 

    @@value = 80

    def initialize(name, expires_in, quality)
        super(name, expires_in, @@value)
    end

    def update_quality
        self.quality = @@value
    end
end 

class BlueStar < Award
    def update_quality
        self.quality -=2 if self.quality > minQuality
        self.expires_in -=1 
        self.quality -= 2 if self.expires_in < 0 &&  self.quality > minQuality
        self.quality = minQuality if self.quality < minQuality
    end
end

