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
				expect(EmptyIndex.indexes(10, 100)).to eq((0..9).to_set)
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

			it 'returns 9 indexes for 99 percent of 10 elements' do
				expect(EmptyIndex.indexes(10, 99).size).to eq 9
			end

			it 'returns 4 indexes for 40 percent of 10 elements' do
				expect(EmptyIndex.indexes(10, 40).size).to eq 4
			end

			it 'returns 3 indexes for 39 percent of 10 elements' do
				expect(EmptyIndex.indexes(10, 39).size).to eq 3
			end

		end

	end
end
