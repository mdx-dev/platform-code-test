require 'award_system'

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality

    validate
  end

  private

  def validate
    unless AwardSystem::AWARD_NAMES.include?(@name)
      raise ArgumentError.new("Award name must be one of: #{AwardSystem::AWARD_NAMES}")
    end
  end
end