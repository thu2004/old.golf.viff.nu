# Try to include the rails initializer. If this isn't in a gem, this will fail.
if Refinery.is_a_gem
  begin
    require 'initializer'
  rescue LoadError => load_error
    # we don't need to do anything.
    puts "*** RefineryCMS gem load failed, attempting to load traditionally... ***"
  end
end

module Refinery

  class Configuration < Rails::Configuration
    def default_plugin_paths
      paths = super.push(Refinery.root.join("vendor", "plugins").to_s).uniq
    end
  end if defined?(Rails::Configuration)

  class PluginLoader < Rails::Plugin::Loader
    def add_plugin_load_paths
      # call rails' add_plugin_load_paths
      super

      # add plugin lib paths to the $LOAD_PATH so that rake tasks etc. can be run when using a gem for refinery or gems for plugins.
      search_for = Regexp.new(File.join(%W(\( #{Refinery.root.join("vendor", "plugins")} \)? .+? lib)))
      paths = plugins.collect{ |plugin| plugin.load_paths }.flatten.reject{|path| path.scan(search_for).empty? or path.include?('/rails-') }
      paths = paths.reject{ |path| path.include?(Refinery.root.to_s) } unless Refinery.is_a_gem
      paths.uniq!
      ($refinery_gem_plugin_lib_paths = paths).each do |path|
        $LOAD_PATH.unshift path
      end
      $LOAD_PATH.uniq!
    end

    # We need to overload this because some gems raise errors if they're not installed
    # rather than just letting the framework handle it so we need to trap them here.
    def ensure_all_registered_plugins_are_loaded!
      begin
        super
      rescue LoadError => load_error
        raise LoadError, load_error.to_s unless load_error.to_s =~ /friendly_id|aasm|will_paginate/
      end
    end
  end if defined?(Rails::Plugin::Loader)

  class Initializer < Rails::Initializer
    def self.run(command = :process, configuration = Configuration.new)
      configuration.plugin_loader = Refinery::PluginLoader
      Rails.configuration = configuration

      # call rails' run
      super
    end

    def load_plugins
      # inject all gems that manipulate ActiveRecord::Base into the application
      # and stub any calls that are dangerous.
      ::ActiveRecord::Base.module_eval do
        begin
          require 'friendly_id'
          require 'will_paginate'
          require 'aasm'
        rescue LoadError => load_error
          # this will stop us running rake gems:install which we don't really want so just trap this error.
          puts "*** Trapping error caused by missing gems ***"
        end

        # Stub has_friendly_id. This will get overriden when/if included.
        # The config will still complain that the gem is missing but this allows it to do so.
        def self.has_friendly_id(column, options = {}, &block)
          super if defined? super and table_exists?
        end
      end

      # call rails' load_plugins
      super
    end
  end if defined?(Rails::Initializer)

end
