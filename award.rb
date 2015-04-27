#Award = Struct.new(:name, :expires_in, :quality)
class Award
  attr_accessor :expires_in, :quality
  attr_reader :name

  def initialize(name, expires_in, quality)
    @award_type = set_award_type(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update
    @expires_in = @award_type.move_day
    @quality = @award_type.update
  end

  def set_award_type(name, expires_in, quality)
    case name
    when 'Blue Compare'
      BlueCompare.new(expires_in, quality)
    when 'Blue Distinction Plus'
      BlueDistinctPlus.new(expires_in, quality)
    when 'Blue First'
      BlueFirst.new(expires_in, quality)
    when 'Blue Star'
      BlueStar.new(expires_in, quality)
    else
      BaseAward.new(expires_in, quality)
    end
  end

end

class BaseAward < Award
  attr_reader :day_change

  def initialize(expires_in, quality)
    @expires_in = expires_in
    @quality = quality
    @max_quality = 50
    @min_quality = 0
    @day_change = 1
  end

  def expired
    @expires_in < 0
  end

  def move_day
    @expires_in -= @day_change
  end

  def check_quality
    if @quality > @max_quality
      @quality = @max_quality
    elsif @quality < @min_quality
      @quality = @min_quality
    end
    @quality
  end

  def update
    (expired) ? @quality -= 2 : @quality -= 1
    check_quality
  end

end

class BlueCompare < BaseAward
  def update
    if expired
      @quality = 0
    else
      case @expires_in
      when (6..10)
        @quality += 2
      when (0..5)
        @quality += 3
      else
        @quality += 1
      end
    end
    check_quality
  end
end

class BlueDistinctPlus < BaseAward
  def initialize(expires_in, quality)
    super
    @day_change = 0
    @max_quality = 80
  end
  def update
    @quality = @max_quality
    check_quality
  end
end

class BlueFirst < BaseAward
  def update
    (expired) ? @quality += 2 : @quality += 1
    check_quality
  end
end

class BlueStar < BaseAward
  def update
    (expired) ? @quality -= 4 : @quality -= 2
    check_quality
  end
end
