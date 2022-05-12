# frozen_string_literal: true

require 'dry/inflector'

class Award
  attr_accessor :name, :expires_in, :quality

  BLUE_FIRST = 'Blue First'
  BLUE_COMPARE = 'Blue Compare'
  BLUE_DISTINCTION_PLUS = 'Blue Distinction Plus'
  BLUE_STAR = 'Blue Star'
  AWARDS = [BLUE_FIRST, BLUE_COMPARE, BLUE_DISTINCTION_PLUS, BLUE_STAR].freeze
  INFLECTOR = Dry::Inflector.new.freeze
  private_constant(
    :BLUE_FIRST, :BLUE_COMPARE, :BLUE_DISTINCTION_PLUS, :BLUE_STAR, :AWARDS, :INFLECTOR
  )

  def initialize(name, initial_expires_in, initial_quality)
    @name = name
    @expires_in = initial_expires_in
    @quality = initial_quality
  end

  AWARDS.each do |award|
    method_name = [INFLECTOR.underscore(award).gsub(/\s+/, '_'), '?'].join

    define_method method_name do
      name == award
    end
  end
end
