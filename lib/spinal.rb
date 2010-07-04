
module Spinal

  def self.require_relative(path)
    @_lib_dir ||= File.dirname(__FILE__)
    require File.expand_path(File.join(@lib_dir, path))
  end
end

Spinal.require_relative 'spinal/resource'
Spinal.require_relative 'spinal/app'

