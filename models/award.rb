require_relative "blue_compare"
require_relative "blue_distinction_plus"
require_relative "blue_first"
require_relative "blue_star"
require_relative "standard_award"

class Award
  def initialize(name, expires_in, quality)
    @type = set_award_type(name, expires_in, quality)
  end

  # getters
  def name
    @type.name
  end

  def expires_in
    @type.expires_in
  end

  def quality
    @type.quality
  end

  # need this assuming I can't change spec file
  def set_award_type(name, expires_in, quality)
    case name
    when 'Blue First'
      BlueFirst.new(name, expires_in, quality)
    when 'Blue Distinction Plus'
      BlueDistinctionPlus.new(name, expires_in, quality)
    when 'Blue Compare'
      BlueCompare.new(name, expires_in, quality)
    when 'Blue Star'
      BlueStar.new(name, expires_in, quality)
    else
      StandardAward.new(name, expires_in, quality)
    end
  end

  def update_quality
    @type.update_quality
  end

  # toString method - dev purposes
  def to_s
     "#{self.singleton_class} name: #{@name}, expires_in: #{@expires_in}, quality: #{@quality}"
  end
end
