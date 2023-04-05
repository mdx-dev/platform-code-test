class BlueStarAward < Award
  def update_quality
    @quality -= 2
    @quality -= 2 if @expires_in <= 0

    @expires_in -= 1

    ensure_within_bounds
  end
end