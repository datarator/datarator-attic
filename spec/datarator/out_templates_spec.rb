require 'spec_helper'
require 'datarator/out_templates'
require 'datarator/out_context'
require 'datarator/type_name'

module Datarator
	describe OutTemplates do
		describe '.validate' do
			it 'passes validation for registered output template' do
				expect(OutTemplates.validate 'csv').to eq nil
			end

			it 'raises ArgumentError for not registered output template' do
				expect{ OutTemplates.validate 'non_existing' }.to raise_error(/template not supported/)
			end
		end
	end

	describe '.find_all' do
		it 'returns all templates available' do
			expect( OutTemplates.find_all ).to match_array(
				[
					{:name=>"csv", :options=>[{:name=>"header", :mandatory=>false, :boolean=>true}]},
					{:name=>"sql", :options=>[]}
				])
		end
	end
end
