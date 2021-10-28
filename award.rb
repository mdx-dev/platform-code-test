class Award
    attr_accessor :name, :expires_in, :quality

    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality
    end

    def max (a,b)
        a>b ? a : b
    end

    def min (a,b)
        a>b ? b : a
    end

    def update_expiration
        @expires_in -= 1
    end

    def update_quality
        if @name != 'Blue Distinction Plus'
            update_expiration
        end

        if @name === 'NORMAL ITEM'
            update_quality_normal
        elsif @name === 'Blue First'
            update_quality_blue_first
        elsif @name === 'Blue Compare'
            update_quality_blue_compare
        elsif @name == 'Blue Star'
            update_quality_blue_star
        end
    end

    def update_quality_normal
        @quality = max(@quality - 1, 0)
        if @expires_in < 0
            @quality = max(@quality - 1, 0)
        end
    end

    def update_quality_blue_first
      if @quality < 50
        @quality += 1
        if @expires_in < 0
            @quality = min(quality + 1, 50)
        end
      end
    end

    def update_quality_blue_compare
      if @quality < 50
        @quality += 1

        if @expires_in < 11
          @quality += 1
        end
        if @expires_in < 6
          @quality += 1
        end
      end
      if @expires_in < 0
          @quality = 0
        end
    end

    def update_quality_blue_star
        @quality = max(@quality - 2, 0)
        if @expires_in < 0
            @quality = max(@quality - 2, 0)
        end
    end

end
