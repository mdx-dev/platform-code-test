# Award = Struct.new(:name, :expires_in, :quality)

class Award

  attr_accessor :type, :name

  def initialize(name, expires_in, quality)
    case name
    when "NORMAL ITEM"
      @type = NormalItem.new(expires_in, quality)
    when "Blue First"
      @type = BlueFirst.new(expires_in, quality)
    when "Blue Compare"
      @type = BlueCompare.new(expires_in, quality)
    when "Blue Distinction Plus"
      @type = BlueDistinctionPlus.new(expires_in, quality)
    when "Blue Star"
      @type = BlueStar.new(expires_in)
    end
    @name = name
  end

  def expires_in
    type.expires_in
  end

  def quality
    type.quality
  end

  def update_type
    type.update
  end

end