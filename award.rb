
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
      NormalAward.new(expires_in, quality)
    end
  end
end

class NormalAward < Award
  attr_reader :day

  def initialize(expires_in, quality)
    @expires_in = expires_in
    @quality = quality
    @max_score = 50
    @min_score = 0
    @day = 1
  end

  def get_quality
    self.expires_in <= 0 ? self.quality -= 2 : self.quality -= 1
    limit_quality
  end

  def limit_quality(min = @min_score, max = @max_score)
    if self.quality > max
      self.quality = max
    elsif self.quality < min
      self.quality = min
    end
    self.quality
  end
end

class BlueDistinctionPlus < NormalAward
  def initialize(expires_in, quality)
    super
    @day = 0
  end

  def get_quality
    self.quality = 80
  end
end

class BlueCompare < NormalAward
  def get_quality
    case
    when @expires_in <= 0
      self.quality = 0
    when (1..5).include?(@expires_in)
      self.quality += 3
    when (6..10).include?(@expires_in)
      self.quality += 2
    else
      self.quality += 1
    end
    limit_quality
  end
end

class BlueFirst < NormalAward
  def get_quality
    @expires_in <= 0 ? @quality += 2 : @quality += 1
    limit_quality
  end
end

class BlueStar < NormalAward
  def get_quality
    @expires_in <= 0 ? @quality -= 4 : @quality -= 2
    limit_quality
  end
end

# Add distinct rules for any future awards here

