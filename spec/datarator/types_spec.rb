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
						{:name=>"name.last_name", :nested=>false, :options=>[]}
					])
			end
		end
	end
end
