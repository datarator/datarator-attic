require 'spec_helper'
require 'datarator/type'

module Datarator
	describe Type do

		describe '.value' do
			it 'raises NotImplementedError' do
				expect{ Type.new.value nil }.to raise_error(NotImplementedError)
			end
		end

		describe '.escape?' do
			it 'raises NotImplementedError' do
				expect{ Type.new.escape? nil }.to raise_error(NotImplementedError)
			end
		end

		describe '.options' do
			it 'returns no options' do
				expect( Type.new.options ).to match_array([])
			end
		end


		# describe '.validate?' do
		# 	it 'raises NotImplementedError' do
		# 		expect{ Type.new.validate nil, nil }.to raise_error(NotImplementedError)
		# 	end
		# end
                #

		describe '.nested?' do
			it 'raises NotImplementedError' do
				expect{ Type.new.nested? }.to raise_error(NotImplementedError)
			end
		end


	end
end


