require 'spec_helper'

class Library
	include Sunspot::ReferentialUpdaters
end

describe Sunspot::ReferentialUpdaters do
	describe '##reindexes' do
		it 'should accept and store N relations to reindex' do
			Library.stubs(:after_save)
			Library.reindexes :books, :authors
			Library.reindexable_relations.should == [:books, :authors]
		end

		it 'should send #after_save to the base with the :reindex_relations symbol' do
			Library.expects(:after_save).with(:reindex_relations!)
			Library.reindexes
		end
	end

	describe '#reindex_relations!' do
		it 'should call #solr_index on all relations' do
			library = Library.new
			relation1 = mock(:solr_index)
			relation2 = mock(:solr_index)
			Library.stubs(:reindexable_relations).returns([relation1, relation2])
			library.send :reindex_relations!
		end
	end
end
