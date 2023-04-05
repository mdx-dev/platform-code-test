class BlueCompareAward < Award
  def update_quality
    if @expires_in <= 0
      @quality = 0
      @expires_in -= 1
      return
    end

    if @quality > 0
      if expires_in < 6
        @quality += 3
      elsif expires_in < 11
        @quality += 2
      else
        @quality += 1
      end
    end

    @expires_in -= 1

    ensure_within_bounds
  end
end