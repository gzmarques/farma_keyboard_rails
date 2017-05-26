module FarmaKeyboardRails
  class Engine < Rails::Engine
    initializer 'handlebars.assets.precompile' do |app|
      require 'handlebars'
    end
  end
end
