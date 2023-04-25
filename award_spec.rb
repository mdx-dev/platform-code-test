# frozen_string_literal: true

require 'rspec'
require 'award'

RSpec.describe Award, '#quality' do
  context 'construction & interface' do
    it 'can be constructed like this' do
      a = Award.new('some name', 1, 2)
      expect(a.name).to eql 'some name'
      expect(a.expires_in).to eql 1
      expect(a.quality).to eql 2
    end
  end

  context '#quality' do
    context 'can never be negative' do
      specify 'when constructing' do
        a = Award.new('some name', 1, -900)
        expect(a.quality).to eq 0
      end

      specify 'when changing an instance' do
        a = Award.new('some name', 1, 34)
        a.quality = -55
        expect(a.quality).to eq 0
      end
    end

    context 'can never be more than 50' do
      specify 'when constructing' do
        a = Award.new('some name', 1, 304)
        expect(a.quality).to eq 50
      end
      specify 'when changing an instance' do
        a = Award.new('some name', 1, 34)
        a.quality = 55
        expect(a.quality).to eq 50
      end
    end

    context 'for Blue Distinction Plus' do
      it 'will be set to 80' do
        a = Award.new('Blue Distinction Plus', 1, 34)
        expect(a.quality).to eq 80
      end

      it 'will never be changed from 80' do
        a = Award.new('Blue Distinction Plus', 1, 34)
        a.quality = 9_000
        expect(a.quality).to eq 80

        a.quality = -9_000
        expect(a.quality).to eq 80
      end
    end

    context '#decrement_expires_in' do
      it 'will default to decrement the expires_in value to 1' do
        a = Award.new('some name', 34, 89)
        a.decrement_expires_in
        expect(a.expires_in).to eq 33
      end

      it 'will allow for expiration decrementing of any value' do
        a = Award.new('some name', 34, 89)
        a.decrement_expires_in(10)
        expect(a.expires_in).to eq 24
      end
    end
  end
end
