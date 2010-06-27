
class Spinal::UrlMap

  def initialize(map = {})
    @map = map
  end

  def append(location, app)
    @map[location] = app
  end

  def match_and_run(env = {})
    if app = @map[env['PATH_INFO']]
      app.call(env)
    else
      not_found_response(env)
    end
  end

  protected

  def not_found_response(env)
    [
      404,
      {"Content-Type" => 'text/plain'},
      ["#{env["PATH_INFO"]} Not Found"]
    ]
  end

end
