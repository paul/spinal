
require 'active_support/concern'

module Spinal::Resource
  extend ActiveSupport::Concern

  attr_reader :app, :resource

  def initialize(app)
    @app = app
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
