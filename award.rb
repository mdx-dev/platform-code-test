require 'pry'

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  # Method to update scores daily (name decided from readme)
  def daily_grade
  # The quality of an award is never negative, && test specs speicfy a return of 0
    if quality + sum_by_type <= 0
      @quality = 0
  # "Blue Distinction Plus", being highly sought, its quality is 80 and it never alters.
    elsif quality == 80 && name == 'Blue Distinction Plus'
      @quality = 80
  # Just for clarification, an award can never have its quality increase above 50
    elsif (quality + sum_by_type) >= 50
      @quality = 50
  # If none of the above apply, calulate totals
    else
      @quality += sum_by_type
    end
  # Based on test specs (line 21,49,93,116,181)
    if name != 'Blue Distinction Plus'
      @expires_in -= 1
    end
  end

    # Method to check expiration
  def expired?
    expires_in <= 0
  end

  # Method to calculate name along with expiration
  def sum_by_type
    # Based on tests (line 24-30)
    if name == 'NORMAL ITEM' && expired?
      -2
    elsif name == 'NORMAL ITEM'
      -1
    end
    # "Blue First" awards actually increase in quality the older they get
    if name == 'Blue First' && expired?
      2
    elsif name == 'Blue First'
      1
    end
    # "Blue Distinction Plus", being a highly sought distinction, never decreases in quality
    if name == 'Blue Distinction Plus'
      0
    end
    # Based off of test specs (lines 111-177)
    if name == 'Blue Compare' && expired?
      quality * -1
    elsif name == 'Blue Compare' && expires_in >= 11
      1
    elsif name == 'Blue Compare' && expires_in >= 6
      2
    elsif name == 'Blue Compare' && expires_in <= 5
      3
    end
    # "Based on test lines (179-214)"
    if name == 'Blue Star' && expired?
      -4
    elsif name == 'Blue Star' && expires_in <= 5
      -2
    end
  end
end



a = Award.new('Blue First', 3, 10)
 binding.pry









