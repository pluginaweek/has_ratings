require_plugin 'acts_association_helper'

require 'acts_as_ratable'

ActiveRecord::Base.class_eval do
  include PluginAWeek::Acts::Ratable
end