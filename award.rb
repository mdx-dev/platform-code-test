require 'award_type'
class Award

  attr_accessor :name, :type

  def initialize(name, expires_in, quality)
    @name = name
    @type = AwardType.new(expires_in, quality)
  end

  def expires_in
    type.expires_in
  end

  def quality
    type.quality
  end

  def update_type
    case name
    when "Blue Compare"
      type.blue_compare
    when "Blue Distinction Plus"
      type.blue_distinction_plus
    when "Blue First"
      type.blue_first
    when "Blue Star"
      type.blue_star
    when "NORMAL ITEM"
      type.normal_item
    end
  end

end
