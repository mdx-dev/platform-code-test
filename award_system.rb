module AwardSystem
  AWARD_NAMES = ['NORMAL ITEM', 'Blue First', 'Blue Distinction Plus', 'Blue Compare', 'Blue Star'].freeze

  def update_quality(awards)
    awards.each { |award| award.calculate }
  end

  module_function :update_quality
end