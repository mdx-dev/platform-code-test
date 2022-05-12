require 'rspec'
require_relative '../awards/blue_compare'

describe '#update_quality' do
  let(:initial_expires_in) { 5 }
  let(:initial_quality) { 10 }
  let(:award) { BlueCompare.new(quality: initial_quality, expires_in: initial_expires_in) }

  context 'when quality is updated' do
    before do
      award.update_quality
      expect(award.expires_in).to eq(initial_expires_in-1)
    end

    context 'long before expiration date' do
      let(:initial_expires_in) { 11 }
      specify { expect(award.quality).to eq(initial_quality+1) }

      context 'at max quality' do
        let(:initial_quality) { 50 }
      end
    end

    context 'medium close to expiration date (upper bound)' do
      let(:initial_expires_in) { 10 }
      specify { expect(award.quality).to eq(initial_quality+2) }

      context 'at max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end

    context 'medium close to expiration date (lower bound)' do
      let(:initial_expires_in) { 6 }
      specify { expect(award.quality).to eq(initial_quality+2) }

      context 'at max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end

    context 'very close to expiration date (upper bound)' do
      let(:initial_expires_in) { 5 }
      specify { expect(award.quality).to eq(initial_quality+3) }

      context 'at max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end

    context 'very close to expiration date (lower bound)' do
      let(:initial_expires_in) { 1 }
      specify { expect(award.quality).to eq(initial_quality+3) }

      context 'at max quality' do
        let(:initial_quality) { 50 }
        specify { expect(award.quality).to eq(initial_quality) }
      end
    end

    context 'on expiration date' do
      let(:initial_expires_in) { 0 }
      specify { expect(award.quality).to eq(0) }
    end

    context 'after expiration date' do
      let(:initial_expires_in) { -10 }
      specify { expect(award.quality).to eq(0) }
    end
  end
end
