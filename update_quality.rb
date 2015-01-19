require 'award'

def update_quality(awards)
  awards.each do |award|
    award.daily_grade
  end
end


