require 'rspec'
require 'update_quality'
require "blue_distinction_plus"
require "blue_compare"
require "blue_first"
require "blue_star"

describe Award do
  describe "validates its validatables" do
    # These are sketched in and should be more formalized for all Award chldren classes.
    # These were written to get the refactoring of the Award class started and left
    # here for posterity and eventual expansion.
    context "Blue Distinction Plus" do
      # These were hard rules given for Blue Distinction Plus
      it "always has a quality of 80" do
        award = BlueDistinctionPlus.new(:expires_in_days => 30)
        expect(award.quality).to eq 80
      end

      it "never decrements quality" do
        award = BlueDistinctionPlus.new(:expires_in_days => 30)
        # Sanity check
        expect(award.quality).to eq 80

        award.update_quality!
        expect(award.quality).to eq 80
      end
    end

    # #################################################################################
    # These are more general rules for the base Award class, but should be specked
    # out for sub classes where appropriate.
    it "doesn't get a quality greater than 50 for Non-Blue Distinction Plus" do
      award = Award.new(:expires_in_days => 30, :quality => 80)
      expect(award.quality).to eq 50

      award = Award.new(:expires_in_days => 30, :quality => 80)
      expect(award.quality).to eq 50
    end

    it "doesn't get a quality less than zero" do
      award = Award.new(:expires_in_days => 30, :quality => -1)
      expect(award.quality).to eq 0
    end
    # end generic validations 
    #################################################################################
  end

  describe "updating quality" do
    context 'when quality is updated' do
      context 'given a normal award' do
        let(:initial_expires_in) { 5 }
        let(:initial_quality) { 10 }
        let(:award) { Award.new(:expires_in_days => initial_expires_in, :quality => initial_quality) }

        before(:each) do
          award.update_quality!
          expect(award.expires_in_days).to eq(initial_expires_in - 1)
        end

        context 'before expiration date' do
          specify { expect(award.quality).to eq(initial_quality - 1) }
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(award.quality).to eq(initial_quality - 2) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(award.quality).to eq(initial_quality - 2) }
        end

        context 'of zero quality' do
          let(:initial_quality) { 0 }
          specify { expect(award.quality).to eq(0) }
        end
      end

      context 'given Blue First' do
        let(:initial_expires_in) { 5 }
        let(:initial_quality) { 10 }
        let(:award) { BlueFirst.new(:expires_in_days => initial_expires_in, :quality => initial_quality) }

        before(:each) do
          award.update_quality!
          expect(award.expires_in_days).to eq(initial_expires_in - 1)
        end

        context 'before expiration date' do
          specify { expect(award.quality).to eq(initial_quality + 1) }

          context 'with max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(award.quality).to eq(initial_quality + 2) }

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
          specify { expect(award.quality).to eq(initial_quality + 2) }

          context 'with max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end
      end

      context 'given Blue Distinction Plus' do
        let(:initial_expires_in) { 5 }
        let(:expected_quality) { 80 }
        let(:award) { BlueDistinctionPlus.new(:expires_in_days => initial_expires_in) }

        before(:each) do
          award.update_quality!
          expect(award.expires_in_days).to eq(initial_expires_in - 1)
        end

        context 'before expiration date' do
          specify { expect(award.quality).to eq(expected_quality) }
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(award.quality).to eq(expected_quality) }
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(award.quality).to eq(expected_quality) }
        end
      end

      context 'given Blue Compare' do
        let(:initial_expires_in) { 5 }
        let(:initial_quality) { 10 }
        let(:award) { BlueCompare.new(:expires_in_days => initial_expires_in, :quality => initial_quality) }

        before(:each) do
          award.update_quality!
          expect(award.expires_in_days).to eq(initial_expires_in - 1)
        end

        context 'long before expiration date' do
          let(:initial_expires_in) { 11 }
          specify { expect(award.quality).to eq(initial_quality + 1) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
          end
        end

        context 'medium close to expiration date (upper bound)' do
          let(:initial_expires_in) { 10 }
          specify { expect(award.quality).to eq(initial_quality + 2) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'medium close to expiration date (lower bound)' do
          let(:initial_expires_in) { 6 }
          specify { expect(award.quality).to eq(initial_quality + 2) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'very close to expiration date (upper bound)' do
          let(:initial_expires_in) { 5 }
          specify { expect(award.quality).to eq(initial_quality + 3) }

          context 'at max quality' do
            let(:initial_quality) { 50 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'very close to expiration date (lower bound)' do
          let(:initial_expires_in) { 1 }
          specify { expect(award.quality).to eq(initial_quality + 3) }

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

      context 'given a Blue Star award' do
        let(:initial_expires_in) { 5 }
        let(:initial_quality) { 10 }
        let(:award) { BlueStar.new(:expires_in_days => initial_expires_in, :quality => initial_quality) }

        before(:each) do
          award.update_quality!
          expect(award.expires_in_days).to eq(initial_expires_in - 1)
        end


        context 'before the expiration date' do
          let(:initial_expires_in) { 5 }
          specify { expect(award.quality).to eq(initial_quality - 2) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'on expiration date' do
          let(:initial_expires_in) { 0 }
          specify { expect(award.quality).to eq(initial_quality - 4) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end

        context 'after expiration date' do
          let(:initial_expires_in) { -10 }
          specify { expect(award.quality).to eq(initial_quality - 4) }

          context 'at zero quality' do
            let(:initial_quality) { 0 }
            specify { expect(award.quality).to eq(initial_quality) }
          end
        end
      end
    end
  end
end
