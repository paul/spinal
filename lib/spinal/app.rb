
require 'active_support/concern'
require 'pp'

# This is Spinal::App
module Spinal::App
  extend ActiveSupport::Concern

  attr_reader :url_map

  def initialize
    @url_map = Spinal::UrlMap.new(resource_map)
  end

  def call(env = {})
    @url_map.match_and_run(env)
  end

  protected

  def resource_map
    resource_map = {}
    self.class.constants.each do |const|
      const = self.class.const_get(const)
      if const.ancestors.include?(Spinal::Resource)
        resource_map[const.resource] = const.new(self)
      end
    end
    resource_map
  end

end
