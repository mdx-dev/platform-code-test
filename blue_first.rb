
class BlueFirst < Award

    def update_quality
        @quality += @expires_in > 0 ? 1 : 2
        @quality = 50 if @quality > 50
        update_expires_in
    end
end