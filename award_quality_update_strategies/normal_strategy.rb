class NormalStrategy
    def update(award)
        if award.quality > 0
            award.quality -= 1
        end

        award.expires_in -= 1

        if award.expires_in < 0 && award.quality > 0
            award.quality -= 1
        end
    end
end