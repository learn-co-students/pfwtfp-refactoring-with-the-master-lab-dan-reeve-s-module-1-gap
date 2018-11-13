require 'spec_helper'
DATA_FILE = 'trials.csv'

describe LuckAnalyzer do
  it 'exists' do
    expect { LuckAnalyzer }.not_to raise_error
  end

  context 'during initialization' do
    it 'expects one argument, a file name for initialization' do
      expect { LuckAnalyzer.new }.to raise_error(ArgumentError), "Use raise to trigger an ArgumentError exception if no argument is passed in"
    end

    it 'expects the initializing argument to be a String ending in CSV' do
      expect { LuckAnalyzer.new("bogus_file") }.to raise_error(ArgumentError), "Use raise to trigger an ArgumentError exception if the argument does not end in .csv"
    end

    it 'expects the initializing argument to be a String ending in CSV' do
      expect { LuckAnalyzer.new("trials.csv") }.not_to raise_error,  "Initialzation should be successful when invoked with a single argument that ends in .csv"
    end
  end

  context 'provides accessor csv_data' do
    before(:each) do
      @la = LuckAnalyzer.new(DATA_FILE)
    end

    it 'returns an Array' do
      expect(@la.csv_data).to be_an(Array)
    end

    it 'returns an Array of 100 elements' do
      expect(@la.csv_data.length).to eq(100)
    end

    it 'returns an Array whose 0th element is also an Array' do
      expect(@la.csv_data[0]).to be_an(Array)
    end
  end

  context 'provides method #common_number_of_trials' do
    before(:each) do
      @la = LuckAnalyzer.new(DATA_FILE)
    end

    it 'responds to #common_number_of_trials' do
      expect(@la.common_number_of_trials).to be_truthy
    end

    it 'responds to #common_number_of_trials' do
      expect(@la.common_number_of_trials).to be(12)
    end
  end

  context 'provides method #least_trials_candidate' do
    before(:each) do
      @la = LuckAnalyzer.new(DATA_FILE)
    end

    it 'returns "Arya"' do
      expect(@la.least_trials_candidate).to eq("Arya")
    end
  end

  context 'provides method #most_trials_candidate' do
    before(:each) do
      @la = LuckAnalyzer.new(DATA_FILE)
    end

    it 'returns "Demetrius"' do
      expect(@la.most_trials_candidate).to eq("Demetrius")
    end
  end
end
