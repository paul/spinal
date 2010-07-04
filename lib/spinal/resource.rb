
require 'active_support/concern'

module Spinal::Resource
  extend ActiveSupport::Concern

  attr_reader :request, :response
  attr_reader :app, :resource


  class RequestError < Exception; end

  class MethodNotAllowed < RequestError; end

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

  def negotiate(&block)
    yield
  end

  def format(format, &block)
    @_current_format = format
    instance_eval(&block)
  end

  TEMPLATE_PATH = "./app/views"
  def template(template_name)
    file_prefix = "#{TEMPLATE_PATH}/#{template_name}.#{@_current_format}"

    Tilt.mappings.keys.each do |ext|
      possible_file = "#{file_prefix}.#{ext}"
      if File.exists?(possible_file)
        return Tilt.new(possible_file)
      end
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
        if const.is_a?(Class) && const.ancestors.include?(Spinal::Resource)
          [const, const.sub_resources]
        else
          nil
        end
      }.compact.flatten.uniq
    end

  end

end
