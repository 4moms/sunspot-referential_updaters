module Sunspot
	module ReferentialUpdaters
		class Railtie < Rails::Railtie
			initializer 'railtie.configure_rails_initialization' do
				::ActiveRecord::Base.send :include, Sunspot::ReferentialUpdaters
			end
		end
	end
end
