class BlueDistinctionPlus < Award
    
    def intialize(name, expires_in, quality)
        super
        @quality = 80
    end

    def update_quality
    end

end
