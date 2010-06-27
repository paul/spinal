
$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
    $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Spinal

end

require 'spinal/resource'
require 'spinal/url_map'
require 'spinal/app'

