
module Rspec
  module Support

    module AppWrapper

      def app
        App.new
      end

      def response
        last_response
      end

      class App
        include Spinal::App

        class Posts
          include Spinal::Resource

          def get
            "Hello, from /posts"
          end

        end

        mount('/posts').name(:posts).to(Posts)

      end

    end
  end

  RSpec.configure { |c| c.include Support::AppWrapper }

end
