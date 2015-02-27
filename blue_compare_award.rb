class BlueCompareAward < NormalAward

  # Computes quality change based on the present value of expires_in
  def quality_change
    # "Blue Compare", similar to "Blue First", increases in quality as the expiration date approaches;
    # Quality increases by 2 when there are 10 days or less left, and by 3 where there are 5 days or less left,
    # but quality value drops to 0 after the expiration date.
    if expired?
      -quality
    else
      case expires_in
      when 1..5
        3
      when 5..10
        2
      else
        1
      end
    end
  end

end
