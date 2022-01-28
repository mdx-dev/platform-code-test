class Award
  attr_accessor :title, :ends_at, :quality

  def initialize(title, ends_at, quality)
    @title = title
    @ends_at = ends_at
    @quality= quality
  end

  def update_quality
    if @title != 'Blue Distinction Plus'
      @ends_at = @ends_at - 1

    end

    case @title
    when 'NORMAL ITEM'
      normal_item
    when 'Blue First'
      blue_first
    when 'Blue Compare'
      blue_compare
    when 'Blue Star'
      blue_star
    end
  end

  def normal_item
    @quality= [@quality- 1, 0].max
    @quality= [@quality- 1, 0].max if @ends_at < 0
  end

  def blue_first
    if @quality< 50
      @quality+= 1
      if @ends_at < 0
        @quality= [@quality+ 1, 50].min
      end
    end
  end

  def blue_compare
    if @ends_at < 0
      @quality= 0
      return
    end

    if @quality< 50
      @quality+= 1

      if @ends_at < 11
        @quality+= 1
      end
      if @ends_at < 6
        @quality+= 1
      end
    end
  end

  def blue_star
    @quality= [@quality- 2, 0].max
    @quality= [@quality- 2, 0].max if @ends_at < 0
  end
end
