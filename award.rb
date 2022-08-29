class Award 

    attr_accessor :name, :expires_in, :quality

    def initialize(name, initial_expires_in, initial_quality)
        @name = name
        @expires_in = initial_expires_in
        @quality = initial_quality
    end

    # invoke a method depending on the award name
    def update_award 
        case @name
        when "NORMAL ITEM", "Blue Star"
          update_star_or_normal
        when "Blue First"
          update_blue_first
        when "Blue Compare"
          update_blue_compare
        when "Blue Distinction Plus"
          update_blue_distinction_plus
        end

        @expires_in -= 1 unless name == 'Blue Distinction Plus'

    end


    private 
        # helper methods
        def expired? 
            @expires_in <= 0
        end

        def quality?
            @quality > 0
        end   

        def subtract(num)
            (@quality - num >= 0) ? @quality -= num : @quality = 0
        end

        def add(num)
            (@quality + num <= 50) ? @quality += num : @quality = 50
        end
        # helper methods


        def update_blue_distinction_plus
            @quality = 80
        end

        def update_star_or_normal
            @name == "Blue Star" ? num = 2 : num = 1
            if expired? && quality?  # expired & quality < 50
                subtract(num * 2)
            elsif quality?          # not expired & quality < 50
                subtract(num)
            end
        end

        def update_blue_first
            expired? == true ? num = 2 : num = 1
            add(num)
        end


        def update_blue_compare # degrades depending on @expires_in
            case @expires_in
            when 11..Float::INFINITY
                add(1)
            when 6..10
                add(2)
            when 1..5
                add(3)
            when -Float::INFINITY..0
                @quality = 0
            end
        end
            

end
