require 'rspec'
require_relative '../awards/award'

describe '#update_quality' do
  let(:initial_expires_in) { 5 }
  let(:initial_quality) { 10 }
  let(:award) { Award.new(quality: initial_quality, expires_in: initial_expires_in) }

  context 'when quality is updated' do
    before do
      award.update_quality
      expect(award.expires_in).to eq(initial_expires_in-1)
    end

    context 'before expiration date' do
      specify { expect(award.quality).to eq(initial_quality-1) }
    end

    context 'on expiration date' do
      let(:initial_expires_in) { 0 }
      specify { expect(award.quality).to eq(initial_quality-2) }
    end

    context 'after expiration date' do
      let(:initial_expires_in) { -10 }
      specify { expect(award.quality).to eq(initial_quality-2) }
    end

    context 'of zero quality' do
      let(:initial_quality) { 0 }
      specify { expect(award.quality).to eq(0) }
    end
  end
end