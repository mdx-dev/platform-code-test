require 'rspec'
require 'require_all'
require_all 'ruby_awards'

describe 'blue_distinction_plus' do
  context 'given invalid quality or expiry' do
    it 'should raise an error if quality is not 80' do
      expect{BlueDistinctionPlus.new(10, 81)}.to raise_error 'Invalid Blue Distinction Plus Quality'
    end

    it 'should raise an error if expiry is lesser than 0' do
      expect{BlueDistinctionPlus.new(-1, 80)}.to raise_error 'Invalid Blue Distinction Plus Expiry'
    end
  end

  context 'given a valid quality and expiry as 1' do
    award =  BlueDistinctionPlus.new(1, 80)
    award.update_quality_and_expiry

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end

  context 'given a valid quality and expiry as 0' do
    award =  BlueDistinctionPlus.new(0, 80)
    award.update_quality_and_expiry

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end
end
