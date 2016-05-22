require 'spec_helper'
require 'datarator/type_number'

module Datarator

	describe TypeNumberBinary do

		describe '.value' do
			it 'returns binary number for min value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberBinary.name, "0", { "min" => "1"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberBinary.new.value(@column).to_i(2)).to be >= 1
			end

			it 'returns binary number for max value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberBinary.name, "0", { "max" => "10"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberBinary.new.value(@column).to_i(2)).to be <= 10
			end

			it 'returns binary number for value range specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberBinary.name, "0", { "min" => "1", "max" => "2"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberBinary.new.value(@column).to_i(2)).to be >= 1
				expect(TypeNumberBinary.new.value(@column).to_i(2)).to be <= 2
			end

		end

		describe '.name' do
			it 'returns a constant: \'number.binary\'' do
				expect(TypeNumberBinary.name).to eq 'number.binary'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeNumberBinary.new.escape? nil).to be false
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNumberBinary.new.nested?).to be false
			end
		end
	end

	describe TypeNumberDecimal do

		describe '.value' do
			it 'returns decimal number for min value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberDecimal.name, "0", { "min" => "1"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberDecimal.new.value(@column).to_i).to be >= 1
			end

			it 'returns decimal number for max value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberDecimal.name, "0", { "max" => "10"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberDecimal.new.value(@column).to_i).to be <= 10
			end

			it 'returns decimal number for value range specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberDecimal.name, "0", { "min" => "1", "max" => "2"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberDecimal.new.value(@column).to_i).to be >= 1
				expect(TypeNumberDecimal.new.value(@column).to_i).to be <= 2
			end

		end

		describe '.name' do
			it 'returns a constant: \'number.decimal\'' do
				expect(TypeNumberDecimal.name).to eq 'number.decimal'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeNumberDecimal.new.escape? nil).to be false
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNumberDecimal.new.nested?).to be false
			end
		end
	end

	describe TypeNumberHexadecimal do

		describe '.value' do
			it 'returns hexadecimal number for min value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberHexadecimal.name, "0", { "min" => "1"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberHexadecimal.new.value(@column).to_i(16)).to be >= 1
			end

			it 'returns hexadecimal number for max value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberHexadecimal.name, "0", { "max" => "10"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberHexadecimal.new.value(@column).to_i(16)).to be <= 10
			end

			it 'returns hexadecimal number for value range specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberHexadecimal.name, "0", { "min" => "1", "max" => "2"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberHexadecimal.new.value(@column).to_i(16)).to be >= 1
				expect(TypeNumberHexadecimal.new.value(@column).to_i(16)).to be <= 2
			end

		end

		describe '.name' do
			it 'returns a constant: \'number.hexadecimal\'' do
				expect(TypeNumberHexadecimal.name).to eq 'number.hexadecimal'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeNumberHexadecimal.new.escape? nil).to be false
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNumberHexadecimal.new.nested?).to be false
			end
		end
	end

	describe TypeNumberOctal do

		describe '.value' do
			it 'returns octal number for min value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberOctal.name, "0", { "min" => "1"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberOctal.new.value(@column).to_i(8)).to be >= 1
			end

			it 'returns octal number for max value specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberOctal.name, "0", { "max" => "10"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberOctal.new.value(@column).to_i(8)).to be <= 10
			end

			it 'returns octal number for value range specified' do
				out_context = OutContext.new
				out_context.count=1
				columns = Columns.new
				out_context.columns = columns

				@column = Column.new("name1", TypeNumberOctal.name, "0", { "min" => "1", "max" => "2"}, nil, out_context)
				columns.columns = [ @column ]

				expect(TypeNumberOctal.new.value(@column).to_i(8)).to be >= 1
				expect(TypeNumberOctal.new.value(@column).to_i(8)).to be <= 2
			end

		end

		describe '.name' do
			it 'returns a constant: \'number.octal\'' do
				expect(TypeNumberOctal.name).to eq 'number.octal'
			end
		end

		describe '.escape?' do
			it 'returns false' do
				expect(TypeNumberOctal.new.escape? nil).to be false
			end
		end

		describe '.nested?' do
			it 'returns false' do
				expect(TypeNumberOctal.new.nested?).to be false
			end
		end
	end
end
