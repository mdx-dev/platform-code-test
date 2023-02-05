class Award

    @@award_type = [
        'NORMAL ITEM',
        'Blue Star',
        'Blue First',
        'Blue Compare',
        'Blue Distinction Plus'
    ]

    attr_reader :name, :expires_in, :quality

    def initialize(name, expires_in, quality)
        @name = name
        @expires_in = expires_in
        @quality = quality
    end

    def update_quality
        transaction(self.clone) do
            downcase_name = name.downcase
            raise "Error: Unknow Award Name -- #{@name}" if !@@award_type.map(&:downcase).include? downcase_name

            send "update_#{downcase_name.gsub(' ', '_')}".to_sym
        end
    end

    def expired?
        @expires_in < 1
    end

    private

    # NORMAL ITEM
    def update_normal_item
        decrease_quality(1)
        decrease_quality(1) if expired?
        decrease_expires_in
    end

    # Blue Star
    def update_blue_star
        decrease_quality(2)
        decrease_quality(2) if expired?
        decrease_expires_in
    end

    # Blue First
    def update_blue_first
        increase_quality(1)
        increase_quality(1) if expired?
        decrease_expires_in
    end

    # Blue Compare
    def update_blue_compare
        if expired?
            decrease_quality(@quality)
        elsif expires_in > 10
            increase_quality(1)
        elsif expires_in > 5
            increase_quality(2)
        else
            increase_quality(3)
        end
        decrease_expires_in
    end

    # Blue Distinction Plus
    def update_blue_distinction_plus
        @quality = 80
    end

    def decrease_expires_in
        @expires_in -= 1
    end

    def increase_quality(num)
        quality_control { @quality += num }
    end

    def decrease_quality(num)
        quality_control { @quality -= num }
    end

    def quality_control
        yield
        @quality = [[0, @quality].max, 50].min
    end

    def transaction(award_backup)
        yield
    rescue => e
        puts e
        @expires_in = award_backup.expires_in
        @quality = award_backup.quality
    end

    # def method_missing(method_name, *args, &block)
    #     update_normal_item
    # end
end
