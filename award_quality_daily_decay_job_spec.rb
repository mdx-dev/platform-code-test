require 'rspec'
require 'award_quality_daily_decay_job'

RSpec.describe AwardQualityDailyDecayJob do
  context '#update' do
    it 'will have the expires_in value decremented' do
      processor = double("processor")
      allow(processor).to receive(:decay)

      award = Award.new('some name', 10, 100)
      allow(award).to receive(:quality_decay_processor).and_return(processor)
      AwardQualityDailyDecayJob.update(award)

      expect(award.expires_in).to eq 9
    end
  end
end