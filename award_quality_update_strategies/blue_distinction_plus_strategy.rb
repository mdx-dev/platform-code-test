class BlueDistinctionStrategy
    def update(award)
        # Never decreases in quality
        award.quality = 80
    end
end