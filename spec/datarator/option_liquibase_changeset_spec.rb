require 'spec_helper'
require 'datarator/option_liquibase_changeset'

module Datarator
  describe OptionLiquibaseChangeset do
    describe '.name' do
      it 'returns a constant: \'changeset\'' do
        expect(OptionLiquibaseChangeset.name).to eq 'changeset'
      end
    end

    describe '.mandatory?' do
      it 'returns false' do
        expect(OptionLiquibaseChangeset.new.mandatory?).to be false
      end
    end

    describe '.boolean?' do
      it 'returns true' do
        expect(OptionLiquibaseChangeset.new.boolean?).to be true
      end
    end
  end
end
