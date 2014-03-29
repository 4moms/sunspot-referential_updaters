require 'spec_helper'

describe Sunspot::ReferentialUpdaters do
	describe '##reindexes' do
		it 'should accept and store N relations to reindex' do
			class Library < Object; end

			Library.include Sunspot::ReferentialUpdaters
			Library.reindexes :books, :authors
			Library.class_variable_get(:relations_to_reindex).should == [:books, :authors]
		end
	end
end
