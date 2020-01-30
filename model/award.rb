require_relative 'normal_award'
require_relative 'blue_first'
require_relative 'blue_dist_plus'
require_relative 'blue_compare'

class Award
  def initialize(name, expires_in, quality)
    @type = init_type(name, expires_in, quality)
  end

  def update!
    @type.update!
  end

  ['name', 'expires_in', 'quality'].each do |attribute|
    define_method "#{attribute}" do
      @type.send(attribute)
    end
  end

  private

  def init_type(name, expires_in, quality)
    case name
    when 'Blue First'
      BlueFirst.new(name, expires_in, quality)
    when 'Blue Distinction Plus'
      BlueDistPlus.new(name, expires_in, quality)
    when 'Blue Compare'
      BlueCompare.new(name, expires_in, quality)
    else
      NormalAward.new(name, expires_in, quality)
    end
  end
end
