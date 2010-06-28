
require './lib/spinal'

class TestApp
  include Spinal::App

  class PostsController
    include Spinal::Resource

    resource '/posts'

    def get
      "Hello from posts"
    end

    class PostController
      include Spinal::Resource

      resource '/posts/:id'

      def get(id = 1)
        "Hello from post ##{id}"
      end
    end
  end

end



run TestApp.new

# vim: ft=ruby
