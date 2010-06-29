
require 'active_support/concern'

module Spinal::Resource
  extend ActiveSupport::Concern

  class RequestError < Exception; end

  class MethodNotAllowed < RequestError; end

  attr_reader :app, :resource

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      response_body = send(env['REQUEST_METHOD'].downcase)
      [
        200,
        {'Content-Type' => 'text/plain'},
        [response_body]
      ]
    rescue RequestError => error
      [
        405,
        {'Content-Type' => 'text/plain'},
        ["Method Not Allowed"]
      ]
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
