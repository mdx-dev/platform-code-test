require 'rspec'
require 'require_all'
require_all 'ruby_awards'

describe 'blue_compare' do
  context 'given invalid quality or expiry' do
    it 'should raise an error if quality is greater than 51' do
      expect{BlueCompare.new(10, 51)}.to raise_error 'Invalid Blue Compare Quality'
    end

    it 'should raise an error if quality is lesser than 0' do
      expect{BlueCompare.new(10, -1)}.to raise_error 'Invalid Blue Compare Quality'
    end

    it 'should raise an error if expiry is lesser than 0' do
      expect{BlueCompare.new(-1, 10)}.to raise_error 'Invalid Blue Compare Expiry'
    end
  end

  context 'given a valid quality and expiry between 6 and 10' do
    award =  BlueCompare.new(9, 20)
    award.update_quality_and_expiry

    it 'should increase the quality by 2' do
      expect(award.quality).to eq(22)
    end
  end

  context 'given a valid quality and expiry between 1 and 5' do
    award =  BlueCompare.new(5, 20)
    award.update_quality_and_expiry

    it 'should increase the quality by 3' do
      expect(award.quality).to eq(23)
    end
  end

  context 'given a valid quality and expiry as 1' do
    award =  BlueCompare.new(1, 20)
    award.update_quality_and_expiry

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end

  context 'given a valid expiry and quality as 50' do
    award =  BlueCompare.new(1, 50)
    award.update_quality_and_expiry

    it 'should set the quality as 50' do
      expect(award.quality).to eq(50)
    end
  end

  context 'given a valid quality and expiry as 0' do
    award =  BlueCompare.new(0, 20)
    award.update_quality_and_expiry

    it 'should set the quality as 0' do
      expect(award.quality).to eq(0)
    end

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end
end
