# Awards are used elsewhere in the system, so their public interface must remain backward compatible
# I take this to mean all the methods available on Structs, which I would hope no one is actually using.
# I'd want to evolve the Award class to be much more encapsulated, i.e.
#   class NormalAward
#     attr_reader :name, :expires_in, :quality # place tighter controls on mutability
#
# where the only possible mutation of state is on quality via the update_quality! method (see below)

# But for now all Award instances must quack like Structs, hence:
NormalAward = Struct.new(:name, :expires_in, :quality) do

  # TODO rename this method update_quality! once needless side-effect is removed
  def update_quality_and_decrement_expires_in!
    self.quality = new_quality_bounded

    # TODO: remove needless state mutation and make this method idempotent and runnable any time
    # i.e. by storing an immutable expiration_date rather than mutable expires_in and just computing
    # the number of days till expiration at any given time without mutating any state
    self.expires_in -= 1
  end

  # Purposely breaking backward compatibility here because of the way name was used as a type marker.
  # Mutating name is clearly a bad thing that should fail fast. This is an example of reasons why I
  # would aggressively evolve the code away from Struct toward class.
  def name=(*args)
    raise "an award's name is not changeable"
  end

  private

  # The quality of an award is never negative.
  QUALITY_LOWER_BOUND = 0
  # The quality of an award is never more than 50
  QUALITY_UPPER_BOUND = 50

  # Computes the new quality (within bounds) based on the present value of expires_in
  def new_quality_bounded
    unbounded_new_quality = (quality + quality_change)
    [QUALITY_LOWER_BOUND, [unbounded_new_quality, QUALITY_UPPER_BOUND].min].max
  end

  # Subclasses override this method to implement type-specific business rules
  def quality_change
    # normal awards decrease in quality (implied requirement)
    result = -1

    # Once the expiration date has passed, quality score degrades twice as fast
    result *= 2 if expired?

    result
  end

  # Returns true if the award has expired
  def expired?
    expires_in <= 0
  end

end
