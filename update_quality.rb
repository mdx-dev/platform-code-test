require 'awards'

# Updates quality for all given awards. Also reduces expires_in by 1 for all awards.
def update_quality(awards)
  awards.each do |award|
    award.update_quality_and_decrement_expires_in!
  end
end
