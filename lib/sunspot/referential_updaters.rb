module Sunspot
  module ReferentialUpdaters
		def self.included(base)
			base.extend(ClassMethods)
		end

		def reindex_relations!
			self.class.reindexable_relations.each do |relationship|
				relation = self.send(relationship)

				unless relation.respond_to? :each
					relation = [ relation ]
				end

				relation.each do |a_relation|
					a_relation.solr_index if a_relation.responds_to? :solr_index
				end

			end
		end

		module ClassMethods
			def reindexes(*relations)
				self.reindexable_relations = relations
				after_save :reindex_relations!
			end

			attr_accessor :reindexable_relations
		end
  end
end
