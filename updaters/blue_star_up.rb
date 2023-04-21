class BlueStar
    def update_quality(award)
        ##if name is blue star, quality should be lost twice as fast
        award.quality -= 2 
        award.quality -= 2 if award.expires_in <= 0
    end
end