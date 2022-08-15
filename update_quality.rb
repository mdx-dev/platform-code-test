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
    (expired == true) ? reductor * 2 : reductor
  }

  blue_compare = lambda { |expires, quality|
  case expires
  when 11..Float::INFINITY then 1
  when 6..10 then 2
  when 1..5 then 3
  when -Float::INFINITY..0 then -quality
  end
  }

  awards.each do |award|

    puts "------The name is: #{name} initial quality is: #{award.quality} expires in: #{award.expires_in}"

    reducer = case name
    when 'Blue Compare' then blue_compare.call(award.expires_in, award.quality)
    else reductor.call(award.name, expired.call(award.expires_in))
    end

    award.quality += reducer if award.quality > 0 and award.quality < 50 # Quality reduce
    (award.quality > 50 && name != 'Blue Distinction Plus') ? award.quality = 50 : award.quality

    award.expires_in -= 1 unless name == 'Blue Distinction Plus'

    puts "- Aftermath Quality: #{award.quality} and expires in: #{award.expires_in}" # Expires_in reduce

  end
end
