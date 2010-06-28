
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
    resources.each { |r| resource_map[r.resource] = r.new(self) }
    resource_map
  end

  def resources
    self.class.constants.map { |c|
      const = self.class.const_get(c)
      const.ancestors.include?(Spinal::Resource)
      [const, const.sub_resources]
    }.flatten.uniq
  end

end
