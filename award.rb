class Award

  attr_accessor :name, :expires_in, :quality
  # Constructor
  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  #Update quality and expiration date method
  def update_quality
    # Checks if expired
    is_expired = Proc.new { |date| date <= 0}
    # Calculate the amount of points an award will gain/lose
    reductor_calculator = lambda { |name, expired|
      reductor = case name
      when 'Blue Distinction Plus' then return reductor = 0
      when 'Blue First','Blue Compare' then 1
      when 'Blue Star' then -2
      when 'NORMAL ITEM' then -1
      end
      (expired == true) ? reductor * 2 : reductor
    }
    # Calculate the amount of points Blue Compare would gain/lose
      blue_compare_calculator = lambda { |expires, quality|
      case expires
      when 11..Float::INFINITY then 1
      when 6..10 then 2
      when 1..5 then 3
      when -Float::INFINITY..0 then -quality
      end
      }
      # Modify current quality based on the reducer amount
    reducer = case @name
    when 'Blue Compare' then blue_compare_calculator.call(@expires_in, @quality)
    else reductor_calculator.call(@name, is_expired.call(@expires_in))
    end
    # Check that it's not going over 50 or under 0
    @quality += reducer if @quality > 0 and @quality < 50
    # Patches the quality for edge cases.
    (@quality > 50 && name != 'Blue Distinction Plus') ? @quality = 50 : @quality
    # Does not change expiration date if it is Blue Disctintion Plus
    @expires_in -= 1 unless name == 'Blue Distinction Plus'

  end
end
