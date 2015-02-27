class BlueStarAward < NormalAward

  def quality_change
    # "Blue Star" awards should lose quality value twice as fast as normal awards.
    super * 2
  end

end
