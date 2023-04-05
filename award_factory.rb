Dir["./awards/*.rb"].each {|file| require file }

class AwardFactory
  REWARD_NAMES = [
    'Blue Compare',
    'Blue Distinction Plus',
    'Blue First',
    'Blue Star'
  ].freeze

  def self.award(name, expires_in, quality)
    puts quality
    case name
    when 'Blue Compare'
      BlueCompareAward.new(name, expires_in, quality)
    when 'Blue Distinction Plus'
      BlueDistinctionPlusAward.new(name, expires_in, quality)
    when 'Blue First'
      BlueFirstAward.new(name, expires_in, quality)
    when 'Blue Star'
      BlueStarAward.new(name, expires_in, quality)
    else
      Award.new(name, expires_in, quality)
    end
  end
end