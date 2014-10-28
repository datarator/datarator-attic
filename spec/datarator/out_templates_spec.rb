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
end
