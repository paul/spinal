
require 'active_support/concern'

module Spinal::Resource
  extend ActiveSupport::Concern

  attr_reader :request, :response

  class RequestError < Exception; end

  class MethodNotAllowed < RequestError; end

  attr_reader :app, :resource

  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new

    begin
      response.write send(request.request_method.downcase)
      response.finish
    rescue RequestError => error
      response.status = 405
      response.write    "Method not allowed"
      response.finish
    end
  end

  def get(*args)
    raise MethodNotAllowed
  end

  def post(*args)
    raise MethodNotAllowed
  end

  def put(*args)
    raise MethodNotAllowed
  end

  def delete(*args)
    raise MethodNotAllowed
  end

  module ClassMethods

    def resource(path = nil)
      if path
        @resource = path
      else
        @resource
      end
    end

    def sub_resources
      self.constants.map { |c|
        const = self.const_get(c)
        if const.ancestors.include?(Spinal::Resource)
          [const, const.sub_resources]
        else
          nil
        end
      }.compact.flatten.uniq
    end

  end

end
