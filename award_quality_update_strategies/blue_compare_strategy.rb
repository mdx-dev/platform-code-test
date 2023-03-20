class BlueCompareStrategy
    def update(award)

        if award.quality < 50
            award.quality += 1
            if award.expires_in < 11
              award.quality += 1
            end
            if award.expires_in < 6
              award.quality += 1
            end
            
            award.quality = [award.quality, 50].min
        end

        award.expires_in -= 1

        # Quality drops to 0 after expiration
        if award.expires_in < 0
            award.quality = 0
        end
    end 
end