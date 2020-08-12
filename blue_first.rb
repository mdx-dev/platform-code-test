class BlueFirst < Award
  private

  def step_quality
    if @quality == 0 || @quality == 50
      return @quality
    end

    change_by = @expires_in_days < 0 ? 2 : 1
    
    @quality = @quality + change_by

    if @quality < 0
      @quality = 0
    end

    if @quality > 50
      @quality = 50
    end

    @quality
  end
end
