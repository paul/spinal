
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

          resource '/posts'

          def get
            "Hello, from /posts"
          end

        end
      end

    end
  end

  RSpec.configure { |c| c.include Support::AppWrapper }

end
