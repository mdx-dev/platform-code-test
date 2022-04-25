Award = Struct.new(:name, :expires_in, :quality)

class Award
  attr_accessor :name, :expires_in, :quality
  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def process_award
    case @name
    when 'NORMAL ITEM'
      normal_item_update
    when 'Blue First'
      blue_first_update
    when 'Blue Compare'
      blue_compare_update
    when 'Blue Star'
      blue_star_update
    end

    if @name != 'Blue Distinction Plus'
      @expires_in -= 1
    end 
  end 

  
  def normal_item_update
    @quality -= 1 unless @quality <= 0
    if @expires_in <= 0
      @quality -= 1 unless @quality <= 0 
    end
  end

  def blue_first_update
    if @quality < 50 
      @quality += 1
      if @expires_in <= 0 
        @quality += 1 unless @quality >=50
      end
    end
  end

  def blue_compare_update
    if @quality < 50
       @quality += 1

      if @expires_in <= 10 && @expires_in > 5
        @quality += 1
      elsif @expires_in <= 5 && @expires_in > 0 
        @quality += 2
      elsif @expires_in <= 0
        @quality = 0
      end
    end
  end

  def blue_star_update
    @quality -= 2 unless @quality <= 0
    if @expires_in <= 0
      @quality -= 2 unless @quality <= 0 
    end
  end
end