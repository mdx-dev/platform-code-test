class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, initial_expires_in, initial_quality)
    @name = name
    @expires_in = initial_expires_in
    @quality = initial_quality
  end

  def handle_award_update
    case @name
    when 'NORMAL ITEM'
      update_normal
    when 'Blue Compare'
      update_blue_compare
    when 'Blue First'
      update_blue_first
    when 'Blue Distinction Plus'
      update_distinction_plus
  end

  def quality_greater_than_zero?
    @quality > 0
  end

  def expired?
    @expires_in <= 0
  end

  def max_quality?
    @quality >= 50 ? @quality = 50 : @quality
  end

  def update_normal
    @quality -= 1 if quality_greater_than_zero?
    @expires_in -= 1
    @quality -= 1 if expired? && quality_greater_than_zero?
  end

  def update_blue_compare
    if expired? 
      @quality = 0
    elsif @expires_in <= 5
      @quality += 3
    elsif @expires_in <= 10
      @quality += 2
    else
      @quality += 1
    end
    max_quality?
    @expires_in -= 1
  end

  def update_blue_first
    @quality += 1 if !max_quality?
    @expires_in -= 1
  end

  def update_distinction_plus
    @expires_in -= 1
  end

# def update_quality(awards)
#   awards.each do |award|
#     if award.name != 'Blue First' && award.name != 'Blue Compare'
#       if award.quality > 0
#         if award.name != 'Blue Distinction Plus'
#           award.quality -= 1
#         end
#       end
#     else
#       if award.quality < 50
#         award.quality += 1
#         if award.name == 'Blue Compare'
#           if award.expires_in < 11
#             if award.quality < 50
#               award.quality += 1
#             end
#           end
#           if award.expires_in < 6
#             if award.quality < 50
#               award.quality += 1
#             end
#           end
#         end
#       end
#     end
#     if award.name != 'Blue Distinction Plus'
#       award.expires_in -= 1
#     end
#     if award.expires_in < 0
#       if award.name != 'Blue First'
#         if award.name != 'Blue Compare'
#           if award.quality > 0
#             if award.name != 'Blue Distinction Plus'
#               award.quality -= 1
#             end
#           end
#         else
#           award.quality = award.quality - award.quality
#         end
#       else
#         if award.quality < 50
#           award.quality += 1
#         end
#       end
#     end
#   end
# end

end