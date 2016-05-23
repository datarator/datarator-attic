require 'spec_helper'
require 'datarator/types'

module Datarator
	describe Types do

		describe '.validate' do
			it 'passes for registered type' do
				Types.validate 'name.name'
			end

			it 'raises error for not registered type' do
				expect{ Types.validate 'non_registered_type' }.to raise_error(ArgumentError)
			end

			it 'raises error for empty type' do
				expect{ Types.validate nil }.to raise_error(ArgumentError)
				expect{ Types.validate '' }.to raise_error(ArgumentError)
			end
		end

		describe '.find_all' do
			it 'returns all types available' do
				expect( Types.find_all ).to match_array(
					[
						{:name=>"const", :nested=>false, :options=>[{:name=>"value", :mandatory=>true, :boolean=>false}]},
						{:name=>"row_index", :nested=>false, :options=>[]},
						{:name=>"copy", :nested=>false, :options=>[{:name=>"from", :mandatory=>true, :boolean=>false}]},
						{:name=>"list.seq", :nested=>true, :options=>[]},
						{:name=>"list.rand", :nested=>true, :options=>[]},
						{:name=>"join", :nested=>true, :options=>[{:name=>"separator", :mandatory=>false, :boolean=>false}]},
						{:name=>"name.name", :nested=>false, :options=>[]},
						{:name=>"name.first_name", :nested=>false, :options=>[]},
						{:name=>"name.last_name", :nested=>false, :options=>[]},
						{:name=>"name.prefix", :nested=>false, :options=>[]},
						{:name=>"name.suffix", :nested=>false, :options=>[]},
						{:name=>"name.title", :nested=>false, :options=>[]},
						{:name=>"bitcoin.address", :nested=>false, :options=>[]},
						{:name=>"book.name", :nested=>false, :options=>[]},
						{:name=>"book.publisher", :nested=>false, :options=>[]},
						{:name=>"book.genre", :nested=>false, :options=>[]},
						{:name=>"boolean", :nested=>false, :options=>[{:name=>"true_ratio", :mandatory=>false, :boolean=>false}]},
						{:name=>"code.isbn", :nested=>false, :options=>[]},
						{:name=>"code.ean", :nested=>false, :options=>[]},
						{:name=>"color.hex", :nested=>false, :options=>[]},
						{:name=>"color.name", :nested=>false, :options=>[]},
						{:name=>"credit_card.number", :nested=>false, :options=>[]},
						{:name=>"credit_card.type", :nested=>false, :options=>[]},
						{:name=>"number.binary", :nested=>false, :options=>[{:name=>"max", :mandatory=>false, :boolean=>false}, {:name=>"min", :mandatory=>false, :boolean=>false}]},
						{:name=>"number.decimal", :nested=>false, :options=>[{:name=>"max", :mandatory=>false, :boolean=>false}, {:name=>"min", :mandatory=>false, :boolean=>false}]},
						{:name=>"number.hexadecimal", :nested=>false, :options=>[{:name=>"max", :mandatory=>false, :boolean=>false}, {:name=>"min", :mandatory=>false, :boolean=>false}]},
						{:name=>"number.octal", :nested=>false, :options=>[{:name=>"max", :mandatory=>false, :boolean=>false}, {:name=>"min", :mandatory=>false, :boolean=>false}]},
						{:name=>"regexp", :nested=>false, :options=>[{:name=>"pattern", :mandatory=>true, :boolean=>false}, {:name=>"escape", :mandatory=>false, :boolean=>true}]}
					])
			end
		end
	end
end
