def update_quality(awards)
  awards.each do |award|
    award.handle_award_update
  end
end
