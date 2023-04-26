require './award'
require './awards_manager'
require './experimental/single_award_manager'
require './experimental/no_instance_award_manager'
require 'benchmark'

def update_quality(awards)
  AwardsManager.new(awards).update_quality
end

def update_single_award_quality(awards)
  awards.each { |award| SingleAwardManager.new(award).update_quality }
end


def update_quality_no_instance(awards)
  awards.each { |award| NoInstanceAwardManager.update_quality(award) }
end

awards = (1..1000000).map {  Award.new('NORMAL ITEM', 5, 10) }

puts "All awards update: #{Benchmark.measure { update_quality(awards) }}"
puts "single instance award update: #{Benchmark.measure { update_single_award_quality(awards) }}"
puts "no manager instantiation award update: #{Benchmark.measure { update_quality_no_instance(awards) }}"
