module Award
  attr_reader :name, :expires_in, :quality
  def update_quality_and_expiry
    fail NotImplementedError, "An award must update it's quality and expiration days every day."
  end
end
