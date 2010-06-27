
require 'active_support/concern'

module Spinal::Resource
  extend ActiveSupport::Concern

  attr_reader :app

  def initialize(app)
    @app = app

    unless defined?(@@resource)
      @@resource = nil
    end
  end

  def call(env)
    body = get
    [
      200,
      {'Content-Type' => 'text/plain'},
      [body]
    ]
  end

  module ClassMethods

    def resource(path = nil)
      if path
        @@resource = path
      else
        @@resource
      end
    end

  end

end
