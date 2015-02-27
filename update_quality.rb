require 'award'

# Updates quality for all given awards. Also reduces expires_in by 1 for all awards.
def update_quality(awards)
  awards.each do |award|

    # "Blue Distinction Plus", being a highly sought distinction, never decreases in quality (and never has its expiration reduced)
    next if award.name == 'Blue Distinction Plus'

    # update quality based on the present value of expires_in
    award.quality = case award.name
                        when 'Blue First'
                          # "Blue First" awards actually increase in quality the older they get
                          quality_increase = 1
                          # Once the expiration date has passed, quality score degrades twice as fast
                          # Apparently they increase twice as fast as well for Blue First
                          quality_increase *= 2 if award.expires_in <= 0
                          [award.quality + quality_increase, 50].min

                        when 'Blue Compare'
                          # "Blue Compare", similar to "Blue First", increases in quality as the expiration date approaches;
                          # Quality increases by 2 when there are 10 days or less left, and by 3 where there are 5 days or less left,
                          # but quality value drops to 0 after the expiration date.
                          if award.expires_in > 0
                            quality_increase = case award.expires_in
                                               when 1..5
                                                 3
                                               when 5..10
                                                 2
                                               else
                                                 1
                                               end
                            [award.quality + quality_increase, 50].min
                          else
                            0
                          end

                        else
                          # normal awards decrease in quality (implied requirement)
                          quality_decrease = 1

                          # Once the expiration date has passed, quality score degrades twice as fast
                          quality_decrease *= 2 if award.expires_in <= 0

                          # "Blue Star" awards should lose quality value twice as fast as normal awards.
                          quality_decrease *= 2 if award.name == 'Blue Star'
                          [award.quality - quality_decrease, 0].max
                        end



    # 3. decrease expires_in
    award.expires_in -= 1

  end
end
