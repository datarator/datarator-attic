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
	end
end
