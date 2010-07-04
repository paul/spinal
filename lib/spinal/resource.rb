
require 'active_support/concern'

module Spinal::Resource
  extend ActiveSupport::Concern

  attr_reader :request, :response
  attr_reader :app


  class RequestError < Exception; end

  class MethodNotAllowed < RequestError; end

  def initialize(app, env)
    @app = app
    @request = env.is_a?(Rack::Request) ? env : Rack::Request.new(env)
    @response = Rack::Response.new
  end

  def path(*args)
    if args.empty?
      app.url(self.class.route)
    else
      app.url(*args)
    end
  end

  def url(*args)
    "#{request.scheme}://#{request.host}#{path(*args)}"
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

  def type
    self.class.to_s
  end

  module ClassMethods

    attr_accessor :route

    def do_get(app, env)
      resource = new(app, env)
      resource.response.write resource.get
      resource.response.finish
    end

  end

end
