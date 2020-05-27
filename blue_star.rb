class BlueStar < Award

    def update_quality
        @quality -= @expires_in > 0 ? 2 : 4
        @quality = 0 if @quality < 0
        update_expires_in
    end

end