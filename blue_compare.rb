class BlueCompare < Award
  private

  def step_quality
    if @quality == 0 || @quality == 50
      return @quality
    end

    # The ranges are 0..5 and 5..10, but have to offset by one because
    # days remaining is updated first.
    if (0..4).cover?(@expires_in_days)
      change_by = 3 
    elsif (5..9).cover?(@expires_in_days)
      change_by = 2
    elsif @expires_in_days < 0
      @quality = 0

      return @quality
    else
      change_by = 1
    end
    
    @quality = @quality + change_by

    if @quality > 50
      @quality = 50
    end

    @quality
  end
end
