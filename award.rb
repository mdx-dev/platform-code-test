# Award = Struct.new(:name, :expires_in, :quality)
class Award
    attr_accessor,:expires_in,:quality
    def initiliaze(name, expires_in,quality)
        self.name = name
        self.expires_in = expires_in
        self.quality = quality
    end

    def calculate_quality_value
        if name == 'Blue First'
            self.quality +=1
        elsif name == 'Blue Compare'
            if expires_in <= 0
                self.equal  = 0
                elsif expires_in <= 5
                    self.quality += 3
                elsif expires_in <= 10
                    self.quality += 2
                else 
                    self.quality += 1
                end
            elsif name == 'Blue Star'
                # Blue star awards lose quality value twice as fast
                self.quality -= 2;
            elsif name !- 'Blue Distinctio Plus' && quality.positve?
                self.quality = 50 if quality > 50
                self.quality = 0 if quality,negative?
            end

    def update_expire_date
        self.expires_in -=1 unless_name = 'Blue Distinction'
    end
end