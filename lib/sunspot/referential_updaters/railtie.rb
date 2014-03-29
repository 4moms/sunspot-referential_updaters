class MyRailtie < Rails::Railtie
  initializer "my_railtie.configure_rails_initialization" do
		ActiveRecord::Base.send :include, Sunspot::ReferentialUpdaters
  end
end
