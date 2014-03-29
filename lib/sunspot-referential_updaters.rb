require "sunspot-referential_updaters/version"

module Sunspot
  module ReferencialUpdaters
		def self.included
			base.extend(ClassMethods)
		end

		module ClassMethods
			def reindexes(*relations)

			end
		end
  end
end
