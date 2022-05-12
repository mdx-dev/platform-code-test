# This is the main class for awards. It is intended to not be direclty created.
class Award
  attr_accessor :quality, :expires_in

  def initialize(**kwargs)
    @quality = kwargs[:quality] || 0
    @expires_in = kwargs[:expires_in] || 0
  end

  # This is the base behavior of what an award should do as quality
  # is updated. This method will be overridden in individual
  # awards classes. Quality can never go below 0.
  def update_quality
    @quality += determine_quality_improvement
    @quality = [@quality, 50].min
    @expires_in -= 1
    self
  end

  def determine_quality_improvement
    return 0 if @quality.zero?

    if @expires_in.positive?
      -1
    else
      -2
    end
  end
end
