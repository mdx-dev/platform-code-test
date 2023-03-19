class BlueStarStrategy
    def update(award)
        if award.quality > 0 && award.expires_in > 0
           award.quality = [award.quality - 2, 0].max
        end
        
        award.expires_in -=1 

        if award.expires_in < 0 && award.quality > 0
            award.quality = [award.quality - 4, 0].max
        end
    end
end