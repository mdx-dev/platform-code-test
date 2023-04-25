# frozen_string_literal: true

require 'rspec'
require 'award'
require 'award_quality_decay_processors'


RSpec.describe AwardQualityDecayProcessors do
  let(:testing_class){ Class.new{ extend AwardQualityDecayProcessors }}

  it 'will return the proper processor for each award type' do
    [['Blue First', AwardQualityDecayProcessors::BlueFirst],
     ['Blue Compare', AwardQualityDecayProcessors::BlueCompare],
     ['Blue Distinction Plus', AwardQualityDecayProcessors::BlueDistinctionPlus],
     ['NORMAL ITEM', AwardQualityDecayProcessors::NormalItem],
     ['Blue Star', AwardQualityDecayProcessors::BlueStar]].each do |values|
       processor = testing_class.retrieve_processor(Award.new(values.first, 10, 100))
       expect(processor.instance_of?(values.last)).to be true
     end
  end

  it 'will raise an error if it cannot find the proper processor' do
    award = Award.new('something wrong', 10, 10)

    expect do
      testing_class.retrieve_processor(award)
    end.to raise_error(AwardQualityDecayProcessors::UnknownProcessor)
  end

  context 'Blue First' do
    it 'will validate the decay of the award when not expired' do
      award = Award.new('Blue First', 10, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 11
    end
    it 'will validate the decay of the award when is expired' do
      award = Award.new('Blue First', -10, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 12
    end
  end

  context 'Blue Compare' do
    it 'will validate the decay of the award when way not expired' do
      award = Award.new('Blue Compare', 1000, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 11
    end

    it 'will validate the decay of the award when the award will expire in 10 days or less' do
      award = Award.new('Blue Compare', 9, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 12
    end

    it 'will validate the decay of the award when the award will expire in 5 days or less' do
      award = Award.new('Blue Compare', 4, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 13
    end

    it 'will validate the decay of the award when the award is expired' do
      award = Award.new('Blue Compare', -10, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 0
    end
  end

  context 'Blue Distinction Plus' do
    it 'will validate the decay of the award when active' do
      award = Award.new('Blue Distinction Plus', 1000, 10)
      expect(award.quality).to eq 80
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 80
    end
    it 'will validate the decay of the award when expired' do
      award = Award.new('Blue Distinction Plus', -1000, 10)
      expect(award.quality).to eq 80
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 80
    end
  end

  context 'Normal Item' do
    it 'will validate the decay of the award when active' do
      award = Award.new('NORMAL ITEM', 1000, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 9
    end
    it 'will validate the decay of the award when expired' do
      award = Award.new('NORMAL ITEM', -1000, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 8
    end
  end

  context 'Blue Star' do
    it 'will validate the decay of the award when active' do
      award = Award.new('Blue Star', 1000, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 8
    end
    it 'will validate the decay of the award when expired' do
      award = Award.new('Blue Star', -1000, 10)
      testing_class.retrieve_processor(award).decay
      expect(award.quality).to eq 6
    end
  end
end
