require 'award'

def update_quality(awards)

  expired = Proc.new { |date| date <= 0}

  reductor = lambda { |name, expired|

    reductor = case name
    when 'Blue Distinction Plus' then return reductor = 0
    when 'Blue First','Blue Compare' then 1
    when 'Blue Star' then -2
    when 'NORMAL ITEM' then -1
    end

    reductor = reductor * 2 if expired

    reductor
  }

  blue_compare = lambda { |expires, reductor, quality|

  case expires
  when expires > 10 then reductor
  when 6..10 then reductor += 1
  when 1..5 then reductor += 2
  when -1000..0 then reductor = -quality
  end

  reductor
  }


  awards.each do |award|

    reducer = reductor.call(award.name, expired.call(award.expires_in))

    puts "------The name is: #{name} initial quality is: #{award.quality} the reducer: #{reducer} expires in: #{award.expires_in}"

    reducer = case name
    when 'Blue Compare' then blue_compare.call(award.expires_in, reducer, award.quality)
    else reducer
    end

    award.quality += reducer if award.quality > 0 and award.quality < 50 # Quality reduce




    award.expires_in -= 1 unless name == 'Blue Distinction Plus'

    puts "- Aftermath Quality: #{award.quality} and expires in: #{award.expires_in}" # Expires_in reduce

  end
end
