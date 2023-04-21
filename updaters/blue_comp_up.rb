class BlueCompare
    def update_quality(award)
        #increase quality as expires_in increases
        award.quality += 1
        # increases the quality by 1 more if the expiration date is less than or equal to 10 days
        award.quality += 1 if award.expires_in <= 10
        #increases the quality by 1 more if the expiration date is less than or equal to 5 days
        award.quality += 1 if award.expires_in <= 5
        #sets the quality to 0 if the expiration date is <= 0
        award.quality = 0 if award.expires_in <= 0
      
    end
  
   
  end