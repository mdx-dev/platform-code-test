require 'rspec'
require 'update_quality'

describe '#update_quality' do

  context 'Given a single award' do
    let(:initial_expires_in) { 5 }
    let(:initial_quality) { 10 }
    let(:award) { Award.new(name, initial_expires_in, initial_quality) }

    context 'when quality is updated' do
      before do
        update_quality([award])
      end

      context 'given a normal award' do
        let(:name) { 'NORMAL ITEM' }

        before do
          # ensure normal awards decline in quality after date of award
          expect(award.expires_in).to eq(initial_expires_in-1)
        end

        context 'before expiration date' do
          # Quality decreases daily prior to expiration
          specify { expect(award.quality).to eq(initial_quality-1) }
        end

        context 'on expiration date' do
          # quality decreases on expiration day
          let(:initial_expires_in) { 0 }
          specify { expect(award.quality).to eq(initial_quality-2) }
        end

        context 'after expiration date' do
          # quality unchanged after expiration day
          let(:initial_expires_in) { -10 }
          specify { expect(award.quality).to eq(initial_quality-2) }
        end

        context 'of zero quality' do
          # aging does not increase quality
          let(:initial_quality) { 0 }
          specify { expect(award.quality).to eq(0) }
        end
      end

      context 'given Blue First' do
        let(:name) { 'Blue First' }

        before do
          # Verify that this is always true in the current context
          award.expires_in.should == initial_expires_in-1
        end

        context 'before expiration date' do
          # Quality increases over time
          specify { expect(award.quality).to eq(initial_quality+1) }

          context 'with max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          # Increment quality on expiration date
          specify { expect(award.quality).to eq(initial_quality+2) }

          context 'near max quality' do
            let(:initial_quality) { 49 }
            # Ensure increment goes to max quality
            specify { expect(award.quality).to eq(50) }
          end

          context 'with max quality' do
            let(:initial_quality) { 50 }
            # Ensure increment does not exceed max quality
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          # Quality increases at double rate after expiration
          specify { expect(award.quality).to eq(initial_quality+2) }

          context 'with max quality' do
            let(:initial_quality) { 50 }
            # Quality can not exceed 50
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end
      end

      context 'given Blue Distinction Plus' do
        let(:initial_quality) { 80 }
        let(:name) { 'Blue Distinction Plus' }

        before do
          # Verify that this is always true in the current context
          award.expires_in.should == initial_expires_in-1
        end

        context 'before expiration date' do
          # award does not increase beyond max quality
          specify { expect(award.quality).to eq(initial_quality) }
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          # award does not increase beyond max quality
          specify { expect(award.quality).to eq(initial_quality) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          # award does not degrade
          specify { expect(award.quality).to eq(initial_quality) }
        end
      end

      context 'given Blue Compare' do
        let(:name) { 'Blue Compare' }

        before do
          # Verify that this is always true in the current context
          award.expires_in.should == initial_expires_in-1
        end

        context 'long before expiration date' do
          let(:initial_expires_in) { 11 }
          # quality increases as expiration approaches
          specify { expect(award.quality).to eq(initial_quality+1) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'medium close to expiration date (upper bound)' do
          let(:initial_expires_in) { 10 }
          # quality+=2 when expire > 5 && <= 10
          specify { expect(award.quality).to eq(initial_quality+2) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'medium close to expiration date (lower bound)' do
          let(:initial_expires_in) { 6 }
          # quality+=2 when expire > 5 && <= 10
          specify { expect(award.quality).to eq(initial_quality+2) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'very close to expiration date (upper bound)' do
          let(:initial_expires_in) { 5 }
          # quality+=3 when expire =< 0 && <= 5
          specify { expect(award.quality).to eq(initial_quality+3) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'very close to expiration date (lower bound)' do
          let(:initial_expires_in) { 1 }
          # quality+=3 when expire =< 0 && <= 5
          specify { expect(award.quality).to eq(initial_quality+3) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          # quality 0 after expiration date
          specify { expect(award.quality).to eq(0) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          # quality 0 after expiration date
          specify { expect(award.quality).to eq(0) }
        end
      end

      context 'given a Blue Star award' do
        let(:name) { 'Blue Star' }

        before do
          # Verify that this is always true in the current context
          award.expires_in.should == initial_expires_in-1
        end

        context 'before the expiration date' do
          let(:initial_expires_in) { 5 }
          # Blue Star loses quality at 2x normal rate
          specify { expect(award.quality).to eq(initial_quality-2) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            # Quality does not drop below 0
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          # Continue to degrade on expiration date
          specify { expect(award.quality).to eq(initial_quality-4) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            # Quality does not drop below 0
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          # Quality degrades at 4x after expiration
          specify { expect(award.quality).to eq(initial_quality-4) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            # Quality does not drop below 0
            specify { expect(award.quality).to eq(initial_quality) }
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
        Award.new('Blue Star', 5, 10),
      ]
    }

    context 'when quality is updated' do
      before do
        update_quality(awards)
      end

      specify { expect(awards[0].quality).to eq(9) }
      specify { expect(awards[0].expires_in).to eq(4) }

      specify { expect(awards[1].quality).to eq(11) }
      specify { expect(awards[1].expires_in).to eq(2) }

      specify { expect(awards[2].quality).to eq(8) }
      specify { expect(awards[2].expires_in).to eq(4) }
    end
  end
end
