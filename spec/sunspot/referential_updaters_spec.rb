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

		context "with singular relation" do
			it 'should call #solr_index on all relations' do
				library = Library.new

				relation1 = :book
				relation2 = :author
				Library.stubs(:reindexable_relations).returns([relation1, relation2])

				mock_relation1 = mock()
				mock_relation1.expects(:solr_index).returns(true)
				mock_relation1.expects(:respond_to?).with(:each).returns(false)
				mock_relation1.expects(:respond_to?).with(:solr_index).returns(true)

				mock_relation2 = mock()
				mock_relation2.expects(:solr_index).returns(true)
				mock_relation2.expects(:respond_to?).with(:each).returns(false)
				mock_relation2.expects(:respond_to?).with(:solr_index).returns(true)


				library.expects(:book).returns(mock_relation1)
				library.expects(:author).returns(mock_relation2)

				library.send :reindex_relations!
			end

			it 'should not raise an error if the relation doesnt respond to #solr_index' do
				obj = mock()
				obj.expects(:respond_to?).with(:each).returns(false)
				obj.expects(:respond_to?).with(:solr_index).returns(false)

				Library.stubs(:reindexable_relations).returns([:things])
				library = Library.new

				library.expects(:things).returns(obj)
				lambda { library.send(:reindex_relations!).should be_true }.should_not raise_exception
			end

		end

		context 'with plural relations' do
			it 'should call #solr_index on each of the relations' do
				library = Library.new

				relation1 = mock()
				relation1.expects(:solr_index).returns(true)
				relation1.expects(:respond_to?).with(:solr_index).returns(true)

				relation2 = mock()
				relation2.expects(:solr_index).returns(true)
				relation2.expects(:respond_to?).with(:solr_index).returns(true)

				relationA = mock()
				relationA.expects(:solr_index).returns(true)
				relationA.expects(:respond_to?).with(:solr_index).returns(true)

				relationB = mock()
				relationB.expects(:solr_index).returns(true)
				relationB.expects(:respond_to?).with(:solr_index).returns(true)

				Library.stubs(:reindexable_relations).returns([:books, :authors])

				library.expects(:books).returns([relation1, relation2])
				library.expects(:authors).returns([relationA, relationB])

				library.send :reindex_relations!
			end

			it 'should not raise an error if a relation doesnt respond to solr_index' do
				obj = mock()
				obj.expects(:respond_to?).with(:solr_index).returns(false)

				Library.stubs(:reindexable_relations).returns([:things])
				library = Library.new

				library.expects(:things).returns([obj])
				lambda { library.send(:reindex_relations!).should be_true }.should_not raise_exception
			end
		end
	end
end
