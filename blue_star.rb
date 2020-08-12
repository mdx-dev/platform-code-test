class BlueStar < Award
  private

  def step_quality
    if @quality == 0
      return @quality
    end

    change_by = @expires_in_days < 0 ? 4 : 2
    
    @quality = @quality - change_by

    if @quality < 0
      @quality = 0
    end
  end
end
