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
				expect{ Type.new.escape? }.to raise_error(NotImplementedError)
			end
		end

	end
end


