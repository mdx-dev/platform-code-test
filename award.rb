#################################################################################
# Refactored into a formal class and sub classes to avoid messy if/else gate.
# * The initial design looked well over due for a refactor.
# * In a Rails app, this would be handled by STI
# * `update_quality` calls virtual functions so that each sub class can handle its
#   own logic by overriding pertinent methods.
# * Name spacing could have been used, but seemed over-engineery to my esthetic.

class Award
  attr_reader :expires_in_days, :quality

  def initialize(expires_in_days:, quality:)
    init_expires_in_days(expires_in_days)
    init_quality(quality)
  end

  def name
    self.class.name
  end

  def update_quality!
    step_expires_in_days
    step_quality
    
  end

  private

  def init_expires_in_days(value)
    @expires_in_days = value
  end

  def step_expires_in_days
    @expires_in_days = @expires_in_days - 1
  end

  def init_quality(value)
    @quality = value > 50 ? 50 : value

    if @quality < 0
      @quality = 0
    end
  end

  def step_quality
    if @quality == 0
      return @quality
    end

    change_by = @expires_in_days < 0 ? 2 : 1
    
    @quality = @quality - change_by

    if @quality < 0
      @quality = 0
    end
  end
end
