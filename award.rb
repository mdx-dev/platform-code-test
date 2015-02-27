Award = Struct.new(:name, :expires_in, :quality) do

  # TODO rename this method update_quality! once needless side-effect is removed
  def update_quality_and_decrement_expires_in!
    # "Blue Distinction Plus", being a highly sought distinction, never decreases in quality
    # and apparently never has its expires_in reduced
    return if name == 'Blue Distinction Plus'

    self.quality = compute_quality

    # TODO: remove needless state mutation and make this method idempotent and runnable any time
    # i.e. by storing expiration date rather than expires_in and computing the number of days
    # till expiration without mutating any state
    self.expires_in -= 1
  end

  private

  # Computes quality based on the present value of expires_in
  def compute_quality
    case name
    when 'Blue First'
      # "Blue First" awards actually increase in quality the older they get
      quality_increase = 1
      # Once the expiration date has passed, quality score degrades twice as fast
      # Apparently they increase twice as fast as well for Blue First
      quality_increase *= 2 if expired?
      [quality + quality_increase, 50].min

    when 'Blue Compare'
      # "Blue Compare", similar to "Blue First", increases in quality as the expiration date approaches;
      # Quality increases by 2 when there are 10 days or less left, and by 3 where there are 5 days or less left,
      # but quality value drops to 0 after the expiration date.
      if expired?
        0
      else
        quality_increase = case expires_in
                           when 1..5
                             3
                           when 5..10
                             2
                           else
                             1
                           end
        [quality + quality_increase, 50].min
      end

    else
      # normal awards decrease in quality (implied requirement)
      quality_decrease = 1

      # Once the expiration date has passed, quality score degrades twice as fast
      quality_decrease *= 2 if expired?

      # "Blue Star" awards should lose quality value twice as fast as normal awards.
      quality_decrease *= 2 if name == 'Blue Star'
      [quality - quality_decrease, 0].max
    end
  end

  def expired?
    expires_in <= 0
  end


end
