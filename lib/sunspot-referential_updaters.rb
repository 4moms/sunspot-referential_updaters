require "sunspot/referential_updaters/version"
require "sunspot/referential_updaters"

if defined?(Rails)
	require 'sunspot/referential_updaters/railtie'
end
