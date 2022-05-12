require 'rspec'
require_relative '../awards/blue_distinction_plus'

describe '#update_quality' do
  let(:initial_quality) { 80 }
  let(:award) { BlueDistinctionPlus.new(quality: initial_quality, expires_in: initial_expires_in) }

  context 'when quality is updated' do
    before do
      award.update_quality
      expect(award.expires_in).to eq(initial_expires_in)
    end

    context 'before expiration date' do
      let(:initial_expires_in) { 5 }
      specify { expect(award.quality).to eq(initial_quality) }
    end

    context 'on expiration date' do
      let(:initial_expires_in) { 0 }
      specify { expect(award.quality).to eq(initial_quality) }
    end

    context 'after expiration date' do
      let(:initial_expires_in) { -10 }
      specify { expect(award.quality).to eq(initial_quality) }
    end
  end
end
