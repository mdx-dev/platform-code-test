# frozen_string_literal: true

require 'forwardable'

require_relative './blue_star'
require_relative './blue_first'
require_relative './blue_distinction_plus'
require_relative './blue_compare'
require_relative './normal_item'

class Award
  extend Forwardable
  def_delegators :@award, :update!, :quality, :expires_in
  attr_accessor :name

  QUALITY_UPPER_LIMIT = 50

  private_constant :QUALITY_UPPER_LIMIT

  def initialize(name, initial_expires_in, initial_quality)
    @name = name

    case
    when BlueStar.match?(name)
      @award = BlueStar.new initial_expires_in, initial_quality
      # p award

    when BlueFirst.match?(name)
      @award = BlueFirst.new initial_expires_in, initial_quality

    when BlueDistinctionPlus.match?(name)
      @award = BlueDistinctionPlus.new initial_expires_in, initial_quality

    when BlueCompare.match?(name)
      @award = BlueCompare.new initial_expires_in, initial_quality

    when NormalItem.match?(name)
      @award = NormalItem.new initial_expires_in, initial_quality

    else
      return
    end
  end
end
