require_relative 'type'
require 'faker'

module Datarator

	class TypeBook < Type
		class << self
			def name
				'book'
			end
		end

		def escape? (column)
			true
		end

		def nested?
			false
		end
	end

	class TypeBookName < TypeBook

		class << self
			def name
				"#{TypeBook.name}.name"
			end
		end

		def value (column)
			Faker::Book.title
		end
	end

	class TypeBookPublisher < TypeBook

		class << self
			def name
				"#{TypeBook.name}.publisher"
			end
		end

		def value (column)
			Faker::Book.publisher
		end
	end

	class TypeBookGenre < TypeBook

		class << self
			def name
				"#{TypeBook.name}.genre"
			end
		end

		def value (column)
			Faker::Book.genre
		end
	end
end
