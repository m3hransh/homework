class HealthRoutes < Sinatra::Base
  get('/') do
    if request.env['HTTP_AUTHORIZATION']
      'App working OK'
    else
      status 403
    end
  end
end
