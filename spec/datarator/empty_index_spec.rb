require 'spec_helper'
require 'datarator/empty_index'

module Datarator
	describe EmptyIndex do

		describe '.indexes' do
			it 'raises ArgumentError for invalid percents' do
				expect{ EmptyIndex.indexes(10, 101) }.to raise_error(ArgumentError)
				expect{ EmptyIndex.indexes(10, -1) }.to raise_error(ArgumentError)
			end

			it 'raises ArgumentError for invalid count' do
				expect{ EmptyIndex.indexes(0, 10) }.to raise_error(ArgumentError)
				expect{ EmptyIndex.indexes(-1, 10) }.to raise_error(ArgumentError)
			end

			it 'returns all indexes for 100 percent' do
				expect(EmptyIndex.indexes(10, 100)).to eq((1..10).to_set)
			end

			it 'returns no index for 0 percent' do
				expect(EmptyIndex.indexes(10, 0).size).to eq 0
			end

			it 'returns 1 index for 10 percent of 10 elements' do
				expect(EmptyIndex.indexes(10, 10).size).to eq 1
			end

			it 'returns 5 indexes for 50 percent of 10 elements' do
				expect(EmptyIndex.indexes(10, 50).size).to eq 5
			end

			# TODO is that correct, or should we generate 9 only???
			it 'returns 10 indexes for 99 percent of 10 elements' do
				expect(EmptyIndex.indexes(10, 99).size).to eq 10
			end
		end

	end
end
