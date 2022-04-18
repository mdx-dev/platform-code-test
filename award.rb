class Award
    @name = nil
    @expires_in = nil
    @quality = nil

    attr_reader :name, :expires_in, :quality

    def initialize(name=nil, expires_in=nil, quality=nil)
        @name = name
        @expires_in = expires_in
        @quality = quality
    end

    def update_quality
            case @name
                when 'Blue First'
                    self.blue_first

                when 'Blue Compare'
                    self.blue_compare

                when 'Blue Distinction Plus'
                    self.blue_distinction_plus

                when 'Blue Star'
                    self.blue_star

                else
                    self.normal
            end
    end

    def normal
        @expires_in -= 1

        if @quality > 0
          @quality -= 1
        end

        if @expires_in < 0
          if @quality > 0
            @quality -= 1
          end
        end
    end

    def blue_first
        @expires_in -= 1

        if @quality < 50
          @quality += 1
        end

        if @expires_in < 0
          if @quality < 50
            @quality += 1
          end
        end
    end

    def blue_compare
        if @quality < 50
          @quality += 1

          if @expires_in < 11
            if @quality < 50
              @quality += 1
            end
          end

          if @expires_in < 6
            if @quality < 50
              @quality += 1
            end
          end
        end

        @expires_in -= 1

        if @expires_in < 0
          @quality = @quality - @quality
        end
    end

    def blue_distinction_plus

    end

    def blue_star
      @expires_in -= 1

      if @quality > 0
        @quality -= 2
      end

      if @expires_in < 0
        if @quality > 0
          @quality -= 2
        end
      end
    end
end
