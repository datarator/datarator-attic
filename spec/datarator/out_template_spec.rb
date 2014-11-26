require 'spec_helper'
require 'datarator/out_template'

module Datarator
	describe OutTemplate do
		describe '.pre' do
			it 'raises NotImplementedError' do
				expect{ OutTemplate.new.pre nil }.to raise_error(NotImplementedError)
			end
		end

		describe '.item' do
			it 'raises NotImplementedError' do
				expect{ OutTemplate.new.item nil }.to raise_error(NotImplementedError)
			end
		end

		describe '.post' do
			it 'raises NotImplementedError' do
				expect{ OutTemplate.new.post nil }.to raise_error(NotImplementedError)
			end
		end


		describe '.empty' do
			it 'raises NotImplementedError' do
				expect{ OutTemplate.new.empty nil }.to raise_error(NotImplementedError)
			end
		end

		describe '.content_type' do
			it 'raises NotImplementedError' do
				expect{ OutTemplate.new.content_type }.to raise_error(NotImplementedError)
			end
		end

		describe '.file_ext' do
			it 'raises NotImplementedError' do
				expect{ OutTemplate.new.file_ext }.to raise_error(NotImplementedError)
			end
		end

		describe '.options' do
			it 'returns no options' do
				expect( OutTemplate.new.options ).to match_array([])
			end
		end

	end
end
