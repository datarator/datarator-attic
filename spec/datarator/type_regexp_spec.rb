require 'spec_helper'
require 'datarator/type_regexp'

module Datarator
	describe TypeRegexp do

		describe '.value' do

			it 'returns random digit for random digit pattern' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeRegexp.name, "0", {"pattern" => "[0-9]"}, nil, out_context)
				columns.columns = [ @column ]
				expect(TypeRegexp.new.value @column).to match(/^[0-9]$/)
			end

			it 'returns random string for random string pattern' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeRegexp.name, "0", {"pattern" => "\S{2,4}"}, nil, out_context)
				columns.columns = [ @column ]
				expect(TypeRegexp.new.value @column).to match(/^\S{2,4}$/)
			end
		end

		describe '.name' do
			it 'returns a constant: \'regexp\'' do
				expect(TypeRegexp.name).to eq 'regexp'
			end
		end

		describe '.escape?' do
			it 'returns true by default' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns
				column = Column.new("col_name", TypeRegexp.name, "0", { "pattern" => ".*" }, nil, out_context)

				expect(TypeRegexp.new.escape? column).to be true
			end

			it 'returns false if explicitly set to false' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns
				column = Column.new("col_name", TypeRegexp.name, "0", { "pattern" => ".*", "escape" => "false"}, nil, out_context)

				expect(TypeRegexp.new.escape? column).to be false
			end

			it 'returns true if explicitly set to true' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns
				column = Column.new("col_name", TypeRegexp.name, "0", { "pattern" => ".*", "escape" => "true"}, nil, out_context)

				expect(TypeRegexp.new.escape? column).to be true
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeRegexp.new.nested?).to be false
			end
		end

	end
end
