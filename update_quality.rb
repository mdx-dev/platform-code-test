require 'award'

def update_quality(awards)

  expired = Proc.new { |date| date <= 0}
  max = Proc.new { |quality| quality == 50}
  min = Proc.new { |quality| quality == 0}

  reductor = lambda { |name, expired|
    puts name, expired

    reductor = case name
    when 'Blue Distinction Plus' then return reductor = 0
    when 'Blue First','Blue Compare' then 1
    when 'Blue Star' then -2
    when 'NORMAL ITEM' then -1
    end

    reductor = reductor * 2 if expired

    reductor
  }


  awards.each do |award|


    reducer = reductor.call(award.name, expired.call(award.expires_in))
    puts reducer




    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
