class BlueFirstAward < NormalAward

  # Computes quality change based on the present value of expires_in
  def quality_change
    # "Blue First" awards actually increase in quality the older they get
    result = 1

    # Once the expiration date has passed, quality score degrades twice as fast
    # Apparently they increase twice as fast as well for Blue First
    result *= 2 if expired?
    result
  end

end
