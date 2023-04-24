require 'award'
require './awards/award_type_factory'

def update_quality(awards)
  awards.each do |award|
    AwardTypeFactory.create_award_type_instance(award).update
  end
end
