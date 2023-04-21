class ValueConstraint
    def update_quality(award)
        #values should be between 0 and 50
        award.quality = 0 if award.quality < 0
        award.quality = 50 if award.quality > 50 && award.name != 'Blue Distinction Plus'
    end
end