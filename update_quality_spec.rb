require 'rspec'
require 'update_quality'

describe '#update_quality' do

  context 'Given a single award' do
    let(:initial_expires_in) { 5 }
    let(:initial_quality) { 10 }
    let(:award) { Award.new(name, initial_expires_in, initial_quality) }
    context 'when quality is updated' do

      context 'given a normal award' do
        let(:name) { 'NORMAL ITEM' }

        context 'before expiration date' do
          specify { expect(update_award_quality(award).quality).to eq(initial_quality-1) }
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality-2) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality-2) }
        end

        context 'of zero quality' do
          let(:initial_quality) { 0 }
          specify { expect(update_award_quality(award).quality).to eq(0) }
        end
      end

      context 'given Blue First' do
        let(:name) { 'Blue First' }

        context 'before expiration date' do
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+1) }

          context 'with max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+2) }

          context 'near max quality' do
            let(:initial_quality) { 49 }
            specify { expect(update_award_quality(award).quality).to eq(50) }
          end

          context 'with max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+2) }

          context 'with max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end
      end

      context 'given Blue Distinction Plus' do
        let(:initial_quality) { 80 }
        let(:name) { 'Blue Distinction Plus' }

        before do
          # Verify that this is always true in the current context
          award.expires_in.should == initial_expires_in
        end

        context 'before expiration date' do
          specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
        end
      end

      context 'given Blue Compare' do
        let(:name) { 'Blue Compare' }

        context 'long before expiration date' do
          let(:initial_expires_in) { 11 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+1) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
          end
        end

        context 'medium close to expiration date (upper bound)' do
          let(:initial_expires_in) { 10 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+2) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'medium close to expiration date (lower bound)' do
          let(:initial_expires_in) { 6 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+2) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'very close to expiration date (upper bound)' do
          let(:initial_expires_in) { 5 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+3) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'very close to expiration date (lower bound)' do
          let(:initial_expires_in) { 1 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality+3) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(update_award_quality(award).quality).to eq(0) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(update_award_quality(award).quality).to eq(0) }
        end
      end

      context 'given a Blue Star award' do
        let(:name) { 'Blue Star' }

        context 'before the expiration date' do
          let(:initial_expires_in) { 5 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality-2) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality-4) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(update_award_quality(award).quality).to eq(initial_quality-4) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            specify { expect(update_award_quality(award).quality).to eq(initial_quality) }
          end
        end
      end
    end
  end

  context 'Given several award' do
    let(:awards) {
      [
        Award.new('NORMAL ITEM', 5, 10),
        Award.new('Blue First', 3, 10),
      ]
    }

    context 'when quality is updated' do
      updated_awards = []
      before do
        updated_awards = update_quality(awards)
      end

      specify { expect(updated_awards[0].quality).to eq(9) }
      specify { expect(updated_awards[0].expires_in).to eq(4) }

      specify { expect(updated_awards[1].quality).to eq(11) }
      specify { expect(updated_awards[1].expires_in).to eq(2) }
    end
  end
end

describe "#respect_limits" do
    specify "sets to 50 when higher" do
       award = Award.new :BLUE_FIRST, 25, 52
       result_award = respect_limits award
       expect(result_award.quality).to eq(50)
    end
    specify "does not alter values above zero or less than 50" do
      [1..50].each{|i|
       award = Award.new :BLUE_FIRST, 25, i
       result_award = respect_limits award
       expect(result_award.quality).to eq(award.quality)
    }
    end

    specify "sets the quality to 0 when it becomes negative" do
       award = Award.new :BLUE_FIRST, 25, -1
       result_award = respect_limits award
       expect(result_award.quality).to eq(0)
    end

    specify "does not touch Blue Distinction Plus" do
       award = Award.new :BLUE_DISTINCTION_PLUS, 25, 80
       result_award = respect_limits award
       expect(result_award.quality).to eq(award.quality)
    end
  
end