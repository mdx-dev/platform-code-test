require './award'
require './award_manager'
require './mass_award_manager'
require './class_award_manager'
require 'benchmark'

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

def update_quality(awards)
  awards.each do |award|
    AwardManager.new(award).update_quality
  end
end

def mass_update_quality(awards)
  MassAwardManager.new(awards).update_quality
end

def class_update_quality(awards)
  awards.each { |award| ClassAwardManager.update_quality(award) }
end

awards = (1..10000000).map {  Award.new('NORMAL ITEM', 5, 10) }

puts "single award update: #{Benchmark.measure { update_quality(awards) }}"
puts "mass award update: #{Benchmark.measure { mass_update_quality(awards) }}"
puts "class award update: #{Benchmark.measure { class_update_quality(awards) }}"
