require 'rspec'
require_relative '../awards/blue_first'

describe '#update_quality' do
  let(:initial_expires_in) { 5 }
  let(:initial_quality) { 10 }
  let(:award) { BlueFirst.new(quality: initial_quality, expires_in: initial_expires_in) }

  context 'when quality is updated' do
    before do
      award.update_quality
      expect(award.expires_in).to eq(initial_expires_in-1)
    end

    context 'before expiration date' do
      specify { expect(award.quality).to eq(initial_quality+1) }

      context 'with max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end

    context 'on expiration date' do
      let(:initial_expires_in) { 0 }
      specify { expect(award.quality).to eq(initial_quality+2) }

      context 'near max quality' do
        let(:initial_quality) { 49 }
        specify { expect(award.quality).to eq(50) }
      end

      context 'with max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end

    context 'after expiration date' do
      let(:initial_expires_in) { -10 }
      specify { expect(award.quality).to eq(initial_quality+2) }

      context 'with max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end
  end
end