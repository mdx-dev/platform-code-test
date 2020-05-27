class BlueCompare < Award

    def update_quality
        case @expires_in
        when -Float::INFINITY..0
            @quality = 0
        when 1..5
            @quality += 3
        when 6..10
            @quality += 2
        when 11..Float::INFINITY
            @quality += 1
        end
        @quality = 50 if @quality > 50
        update_expires_in
    end
end