#Award = Struct.new(:name, :expires_in, :quality)
class Award
  attr_accessor :expires_in, :quality
  attr_reader :name

  
  def initialize(name, expires_in, quality)
    @award_type = set_award_type(name, expires_in, quality)
    @name = name
    @expires_in = @award_type.expires_in
    @quality = quality
  end

  def update_quality
    @quality = @award_type.get_quality
  end

  def advance_day
    @expires_in -= @award_type.day
  end

  Class BaseAward < Award
    attr_reader :day_change
    def initialize(expires_in, quality)
      @expires_in = expires_in
      @quality = quality
      @max_quality = 50
      @min_quality = 0
      @day_change = 1
    end
    def expired
      return self.expires_in < 0
    end
    def move_day
      self.expires_in -= self.day_change
    end
    def check_quality
      if self.quality > self.max_quality
        self.quality = self.max_quality
      elsif self.quality < self.min_quality
        self.quality = self.min_quality
      end
      return self.quality
    end
    def update
      move_day
      expired ? self.quality -= 2 : self.quality -= 1
      check_quality
    end
  end

  Class BlueCompare < BaseAward
    def update
      move_day
      if expired
        self.quality = 0
      else
        case self.expires_in
        when (6..10)
          self.quality += 2
        when (0..5)
          self.quality += 3
        else
          self.quality += 1
        end
      end
      check_quality
    end
  end

  Class BlueDistinctPlus < BaseAward
    def initialize(expires_in, quality)
      super
      @day_change = 0
      @max_quality = 80
    end
    def update
      self.quality = self.max_quality
    end
  end

  Class BlueFirst < BaseAward
    def update
      move_day
      expired ? self.quality += 2 : self.quality += 1
      check_quality
    end
  end

  Class BlueStar < BaseAward
    def update
      move_day
      expired ? self.quality -= 4 : self.quality -= 2
      check_quality
    end
  end
  
  def set_award_type(name, expires_in, quality)
    case name
    when 'Blue Distinction Plus'
      BlueDistinctionPlus.new(expires_in, quality)
    when 'Blue Compare'
      BlueCompare.new(expires_in, quality)
    when 'Blue First'
      BlueFirst.new(expires_in, quality)
    when 'Blue Star'
      BlueStar.new(expires_in, quality)
    else
      BaseAward.new(expires_in, quality)
    end
  end

end
