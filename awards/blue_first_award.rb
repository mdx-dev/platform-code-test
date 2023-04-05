class BlueFirstAward < Award
  def update_quality
    if @expires_in <= 0
      @quality += 2
    else
      @quality += 1
    end

    @expires_in -= 1

    ensure_within_bounds
  end
end