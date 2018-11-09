require 'spec_helper'

describe 'LuckAnalyzer' do
  context 'tells us who the luckiest candidate is' do
    before(:each) do
      @la = LuckAnalyzer.new('spec/spec.csv')
    end

    context 'by calling #create_dice_roll it creates new DiceRoller instances' do
      before(:each) do
        @dr = @la.create_dice_roll(10, "9,8")
      end

      it 'returns a new DiceRoller' do
        expect(@dr).to be_a(DiceRoller)
      end

      it 'returns a DiceRoller with pips count 10' do
        expect(@dr.dice_count).to eq(2)
      end

      it 'returns a DiceRoller whose dice have 10 pips' do
        expect(@dr.dice.first.max_pips).to eq(10)
      end
    end

    context 'by calling name_to_dice_rolls it returns a Hash of e.g. candidate_name => [DiceRoller...n]' do
      before(:each) do
        @results = @la.name_to_dice_rolls
      end

      it 'uses the names of the candidates as keys' do
        expect(@results.keys).to eq(["Arya", "Belinda", "Max"])
      end

      it 'uses the names of the candidates as keys' do
        expect(@results.values.map(&:count)).to eq([2,1,2])
      end
    end

    context 'by calling name_to_rolls_lucky_status it returns a Hash of e.g. candidate_name => [true, false, true, true, false]' do
      before(:each) do
        @results = @la.name_to_rolls_lucky_status
      end

      it 'uses the names of the candidates as keys' do
        expect(@results.keys).to eq(["Arya", "Belinda", "Max"])
      end

      it 'identifies "Arya" as true, false' do
        expect(@results["Arya"]).to eq([true,false])
      end

      it 'identifies "Belinda" as false' do
        expect(@results["Belinda"]).to eq([false])
      end

      it 'identifies "Max" as false,false' do
        expect(@results["Max"]).to eq([false,false])
      end
    end

    context 'by calling name_to_luck_percentages it returns a Hash of e.g. candidate_name => percentage' do
      before(:each) do
        @results = @la.name_to_luck_percentages
      end

      it 'uses the names of the candidates as keys' do
        expect(@results.keys).to eq(["Arya", "Belinda", "Max"])
      end

      it 'identifies "Arya" as true, false' do
        expect(@results["Arya"]).to be_within(0.1).of(100.0)
      end

      it 'identifies "Belinda" as false' do
        expect(@results["Belinda"]).to be_within(0.1).of(0)
      end

      it 'identifies "Max" as false,false' do
        expect(@results["Max"]).to be_within(0.1).of(0)
      end
    end
    it "correctly identifies Byron as the luckiest with ~58% lucky" do
      la = LuckAnalyzer.new("trials.csv")
      expect(la.luckiest).to eq("Byron (58)")
    end
  end
end
