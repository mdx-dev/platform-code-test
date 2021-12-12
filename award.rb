class Award
    attr_accessor :name, :expires_in, :quality

    def initialize (name, expires_in, quality) 
        @name       = name
        @expires_in = expires_in
        @quality    = quality
    end

    # everything but Blue Distinction Plus should stay between 50 and 0
    def boundries
        if @quality < 0
            @quality = 0
        elsif @quality > 50
            @quality = 50
        end
    end
    
    # everything except Blue Distinction Plus should expire
    def experation
        @expires_in -= 1
    end

    # runs quality change methods based on award name
    def update_quality
        if @name != 'Blue Distinction Plus'
            if @name == 'Blue Compare' 
                update_quality_blue_compare
            elsif @name == 'Blue First'
                update_quality_blue_first
            elsif @name == 'Blue Star'
                update_quality_blue_star
            else
                update_quality_standard            
            end
        end
    end

    # Update the quality values for blue compare award
    def update_quality_blue_compare
        if @expires_in > 0
            if @expires_in < 6
                @quality += 3
            elsif @expires_in < 11
                @quality += 2
            else 
                @quality += 1
            end
        end    
        experation
        if @expires_in < 0
            @quality = 0
        end
        boundries
    end


    # Update quality values for the blue first award
    def update_quality_blue_first
        if @quality < 50
            @quality += 1
        end
        experation
        if @expires_in < 0 && @quality < 50
            @quality += 1
        end
        boundries
    end

    # Update quality values for the blue star award
    def update_quality_blue_star
        experation
        if @expires_in > 0
            @quality -= 2
        else
            @quality -= 4
        end
        boundries
    end

    #  Default values 
    def update_quality_standard
        experation
        if @expires_in > 0 && @quality > 0
            @quality -= 1
        elsif @expires_in < 0 && @quality > 0
            @quality -= 2
        end
        boundries
    end  
end