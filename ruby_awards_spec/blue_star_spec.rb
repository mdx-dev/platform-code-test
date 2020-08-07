require 'rspec'
require 'require_all'
require_all 'ruby_awards'

describe 'blue_star' do
  context 'given invalid quality or expiry' do
    it 'should raise an error if quality is greater than 51' do
      expect{BlueStar.new(10, 51)}.to raise_error 'Invalid Blue Star Quality'
    end

    it 'should raise an error if quality is lesser than 0' do
      expect{BlueStar.new(10, -1)}.to raise_error 'Invalid Blue Star Quality'
    end

    it 'should raise an error if expiry is lesser than 0' do
      expect{BlueStar.new(-1, 10)}.to raise_error 'Invalid Blue Star Expiry'
    end
  end

  context 'given a valid quality and expiry as 2' do
    award =  BlueStar.new(2, 20)
    award.update_quality_and_expiry

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end

  context 'given a valid quality and expiry as 1' do
    award =  BlueStar.new(1, 20)
    award.update_quality_and_expiry

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end

  context 'given a valid expiry and quality as 50' do
    award =  BlueStar.new(10, 50)
    award.update_quality_and_expiry

    it 'should set the quality as 49' do
      expect(award.quality).to eq(49)
    end
  end

  context 'given a valid quality and expiry as 0' do
    award =  BlueStar.new(0, 20)
    award.update_quality_and_expiry

    it 'should set the quality as 0' do
      expect(award.quality).to eq(0)
    end

    it 'should set the expiry as 0' do
      expect(award.expires_in).to eq(0)
    end
  end
end
