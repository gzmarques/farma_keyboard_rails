module FarmaKeyboardRails
  class Engine < Rails::Engine
    initializer 'handlebars.assets.precompile' do |app|
      require 'handebars'
    end
  end
end
