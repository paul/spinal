
require 'active_support/concern'
require 'http_router'

# This is Spinal::App
module Spinal::App
  extend ActiveSupport::Concern

  def initialize
  end

  def call(env = {})
    router.call(env)
    resource = env['router.response'].route.dest
    request = Rack::Request.new(env)
    resource.new(request).call
  end

  def url(*args)
    router.url(*args)
  end

  def router
    self.class.router
  end

  module ClassMethods

    def router
      @router ||= HttpRouter.new(:middleware => true)
    end

    def mount(*args)
      router.add(*args)
    end

  end

end
