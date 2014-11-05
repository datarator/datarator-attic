require 'spec_helper'
require 'datarator/column'

module Datarator
	describe Columns do
		before(:each) do
			@out_context = OutContext.new
			@column = Column.new('name', TypeNameFirstName.name, "0", nil, nil, @out_context)
		end

		describe '.escape' do
			it 'returns escape flag based on type' do
				@column.type = 'name.name'
				expect(@column.escape).to be true
				@column.type = 'row_index'
				expect(@column.escape).to be false
			end
		end

		describe '.name=' do
			it 'sets column name' do
				@column.name = 'name2'
				expect(@column.name).to eq 'name2'
			end

			it 'raises ArgumentError for empty column name' do
				expect { @column.name = '' }.to raise_error(ArgumentError)
				expect { @column.name = nil }.to raise_error(ArgumentError)
			end
		end

		describe '.type=' do
			it 'sets column type' do
				@column.type = 'name.name'
				expect(@column.type).to eq 'name.name'
			end

			it 'raises error for unknown column type' do
				expect{ @column.type = 'non_exising' }.to raise_error(ArgumentError)
			end

			it 'raises error for empty column type' do
				expect{ @column.type = '' }.to raise_error(ArgumentError)
				expect{ @column.type = nil }.to raise_error(ArgumentError)
			end
		end

		describe '.empty_percent=' do
			it 'sets empty percents' do
				@column.empty_percent = 100
				expect(@column.empty_percent).to eq 100
			end

			it 'sets empty percents to 0 for empty value' do
				@column.empty_percent = nil
				expect(@column.empty_percent).to eq 0
			end

			it 'raises ArgumentError for invalid percents' do
				expect{ @column.empty_percent = 101 }.to raise_error(ArgumentError)
				expect{ @column.empty_percent = -1 }.to raise_error(ArgumentError)
			end
		end

		describe '.empty_index?' do

			it 'returns false for nested columns (unintialized @empty_indexes)' do
				expect(@column.empty_index?).to be false
			end

			it 'returns true for empty index' do
				@column.empty_indexes = [ 0 ]
				expect(@column.empty_index?).to be true
			end

			it 'returns true for non-empty index' do
				@column.empty_indexes = [ 1 ]
				expect(@column.empty_index?).to be false
			end
		end

		describe '.nested=' do
			context 'having column type requiring nesting' do
				before(:each) do
					nested = [ Column.new('bar', TypeNameName.name, "0", nil, nil, @out_context) ]
					@column = Column.new('foo', TypeJoin.name, "0", { "separator" => ","}, nested, @out_context)
				end

				# it 'raises ArgumentError for missing nesting' do
				# 	expect{ @column.nested = nil }.to raise_error(ArgumentError)
				# end

				it 'sets nested' do
					nested = [ Column.new('nested', TypeNameFirstName.name, "0", nil, nil, @out_context) ]
					@column.nested = nested
					expect(@column.nested).to eq nested
				end

				it 'raises ArgumentError for non array' do
					expect{ @column.nested = 'non_array' }.to raise_error(ArgumentError)
				end

				it 'raises ArgumentError for any nested beeing empty' do
					expect{ @column.nested = [ nil ] }.to raise_error(ArgumentError)
				end

				it 'raises ArgumentError for any nested not of Column type' do
					expect{ @column.nested = [ 'non_column' ] }.to raise_error(ArgumentError)
				end
			end

			context 'having column type requiring no nesting' do
				before(:each) do
					@column = Column.new('foo', TypeNameName.name, "0", nil, nil, @out_context)
				end

				# it 'raises ArgumentError for nesting present' do
				# 	nested = [ Column.new('nested', TypeNameFirstName.name, "0", nil, nil, @out_context) ]
				# 	expect{ @column.nested = nested }.to raise_error(ArgumentError)
				# end
			end

		end

		describe '.out_context=' do
			it 'sets out_context' do
				@column.out_context = @out_context
				expect(@column.out_context).to eq @out_context
			end

			it 'raises ArgumentError for non OutContext type' do
				expect{ @column.out_context = 'non_out_context' }.to raise_error(ArgumentError)
			end

			it 'raises ArgumentError for nil' do
				expect{ @column.out_context = nil }.to raise_error(ArgumentError)
			end
		end
	end
end


