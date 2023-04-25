# frozen_string_literal: true

require 'award_quality_decay_processors'

class Award
  include AwardQualityDecayProcessors

  attr_reader :quality
  attr_accessor :name, :expires_in

  def initialize(name, expires_in, quality)
    self.name = name
    self.expires_in = expires_in
    self.quality = quality
  end

  def quality=(quality)
    if name.eql? 'Blue Distinction Plus'
      @quality = 80
      return
    end

    # quality can never be negative
    if quality.negative?
      @quality = 0
      return
    end

    # quality can never be more than 50
    if quality > 50
      @quality = 50
      return
    end

    @quality = quality
  end

  def decrement_expires_in(amount = 1)
    # there's no business rule stating the BDP type awards cannot have
    # their expired_in value changed, but there is a test checking
    # to make sure the value doesn't change when the update_quality job
    # runs. that job calls this method so the value doesn't change.
    # however, you can change it all day long via the writer
    return if name.eql? 'Blue Distinction Plus'

    self.expires_in -= amount
  end

  def decay_quality
    # AwardQualityDecayProcessors::retrieve_processor
    retrieve_processor(self).decay
  end
end
