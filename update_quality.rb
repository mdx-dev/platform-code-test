require 'award'


def update_quality(awards)
  awards.each do |a|
    if a.name != 'Blue Distinction Plus'
      a.expires_in -= 1
          case a.name
              when 'Blue First'
                a.increment(1)
              when 'Blue Compare'
                if a.expired?
                    a.quality = 0
                elsif a.expires_in < 5
                    a.quality += 3
                elsif a.expires_in < 10
                    a.quality += 2
                else
                    a.quality += 1
                end  
              when 'NORMAL ITEM'          
                a.increment(-1)

              when 'Blue Star'
                a.increment(-2)
          end
      if a.quality > 50
        a.quality = 50
      elsif a.quality < 0
        a.quality = 0
      end
    end
  end
end
