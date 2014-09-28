require 'spec_helper'
require 'datarator/type'

module Datarator
	describe Type do

		describe '.value' do
			it 'raises NotImplementedError' do
				expect{ Type.new.value }.to raise_error(NotImplementedError)
			end
		end
	end
end


