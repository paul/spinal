
require './lib/spinal'

class TestApp
  include Spinal::App

  class Post
    include Spinal::Resource

    resource '/'

    def get
      "Hello"
    end
  end

end



run TestApp.new

# vim: ft=ruby
