module Sunspot
  module ReferentialUpdaters
		def self.included(base)
			base.extend(ClassMethods)
		end

		def reindex_relations!
			self.class.reindexable_relations.each do |relationship|
				relation = self.send(relationship)

				if relation.respond_to? :each
					relation.map(&:solr_index)
				else
					relation.solr_index
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
