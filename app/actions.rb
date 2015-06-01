set sessions: true

helpers do 
  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def last_page_url
    request.referer.starts_with?(settings.domain_name) ? URI(request.referer).path : '/'
  end

  def sign_in(user)
    session[:user_id] = user.id 
  end

  def sign_out
    session.clear
    current_user = nil
  end

  def generate_html_code(transit_mode, params)
    transit_mode.fare = <<-HTML
    <p><strong>Fare Types:</strong><br>#{params[:fare_type]}<p>
    <p><strong>Where to buy:</strong><br>#{params[:fare_where]}<p>
    <p><strong>Using fares:</strong><br>#{params[:fare_how]}<p>
    HTML
    transit_mode.transfers = <<-HTML
    <p><strong>Obtaining a transfer:</strong><br>#{params[:transfer_how]}<p>
    <p><strong>When you'll need a transfer:</strong><br>#{params[:transfer_when]}<p>
    <p><strong>What other services you can transfer to:</strong><br>#{params[:transfer_other]}<p>
    <p><strong>Time limits:</strong><br>#{params[:transfer_limit]}<p>
    HTML
  end

end

before do
  @flash = session[:flash]
  session[:flash] = nil
  @confirm = session[:confirm]
  session[:confirm] = nil
  @user ||= User.new
end

get '/' do 
  erb :index
end

post "/login" do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:confirm] = ["You've successfully logged in!"]
    sign_in(user)
  else
    session[:flash] = ['The username or password is incorrect! Sign in unsuccessful!']
  end
  redirect last_page_url
end 

post "/logout" do 
  sign_out
  session[:confirm] = ["You've been logged out successfully"]
  redirect '/'
end

post '/search' do 
  @cities = City.where(name: params[:city_name])
 
  if @cities.length > 1
    erb :'cities/pick_city'
  elsif @cities.length > 0
    redirect "/cities/#{@cities[0].id}"
  else
    if current_user
      session[:flash] = ["There is no page for this city! Do you want to create a new page?"]
    else
      session[:flash] = ["There is no page for this city! Login to be able to create new pages!"]
    end
    session[:city_name] = params[:city_name]
    redirect '/cities/new'
  end
end

get '/users/new' do
  redirect '/' if current_user
  erb :'users/new'
end

post '/users' do
  user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
    )
  if user.save
    sign_in(user)
    redirect '/'
  else
    session[:flash] = user.errors.full_messages
    redirect '/users/new'
  end
end

get '/users/show' do
  erb :'users/show'
end

post '/users/show' do 
  current_user.pic_url = params[:pic_url]
  if current_user.save
    redirect '/users/show' 
  else
    erb :'/users/show'
  end
end


get '/cities/new' do
  failed_city_name = nil
  if session[:city_name]
    failed_city_name = session[:city_name]
    session[:city_name] = nil
  end
  if current_user
    erb :'/cities/new'
  else
    erb :index
  end
end

post '/cities' do
  @city = City.new(
    name: params[:name],
    country: params[:country]
  )
  @city.state = params[:state] unless params[:state].chomp.empty?
  if @city.save
    session[:confirm] = ["You've successfully created a new page for this city!"]
    redirect "/cities/#{@city.id}/transit_modes/new"
  else
    session[:flash] = @city.errors.full_messages
    redirect '/cities/new'
  end

end

get '/cities/:id' do 
  @city = City.find(params[:id])
  erb :'cities/show'
end

get '/cities/:city_id/transit_modes/new' do 
  @city = City.find(params[:city_id])
  erb :'transit_modes/new'
end

post '/cities/:city_id/transit_modes' do
  city = City.find(params[:city_id])
  transit_modes = city.transit_modes.new(
    name: params[:name],
    icon: params[:icon])
  if transit_modes.save
    redirect "/cities/#{city.id}/transit_modes/new"
  else
    session[:flash] = transit_modes.errors.full_messages
    redirect "/cities/#{city.id}/transit_modes/new"
  end

end

get '/cities/:city_id/transit_modes/' do
  redirect "/cities/#{params[:city_id]}" unless current_user
  @city = City.find(params[:city_id]) 
  erb :'transit_modes/index'
end

get '/cities/:city_id/transit_modes/:transit_mode_id/edit' do
  @city = City.find(params[:city_id])
  @transit_mode = @city.transit_modes.find(params[:transit_mode_id])
  if session[:edits]
    @edits = session[:edits]
    session[:edits] = nil
  end
  erb :'transit_modes/edit'
end

put '/cities/:city_id/transit_modes/:transit_mode_id' do
  @city = City.find(params[:city_id])
  @transit_mode = @city.transit_modes.find(params[:transit_mode_id])
  generate_html_code(@transit_mode, params)
  if @transit_mode.save
    redirect "/cities/#{@city.id}/pics/new"
  else
    session[:flash] = @transit_mode.errors.full_messages
    session[:edits] = params
    redirect "/cities/#{@city_id}/transit_modes/#{@transit_mode.id}/edit"
  end
end

get '/cities/:city_id/pics/new' do 
  @city = City.find(params[:city_id])
  erb :'pics/new'
end

post '/cities/:city_id/pics' do
  @pic = Pic.new(
    user_id: current_user.id,
    city_id: params[:city_id],
    path: params[:path],
    title: params[:title]
    )
  if @pic.save
    #TODO: redirect to city page
    redirect'/cities/:city_id'
  else
    erb :'/pics/new'
  end
end

# get '/cities/:city_id/pics/:id' do
#   @city = City.find(params[:city_id])
#   @pic = @city.pics.find(params[:id])
#   erb :'/ities/:ci
# end

get '/cities/:city_id/problems/new' do 
  @city = City.find(params[:city_id])
  erb :'/problems/new'
end

post '/cities/:city_id/problems' do
# TODO: save problem content to db and if saved properly, redirect to previous city page 
  @city = City.find(params[:city_id])
  # erb :'/cities/show'
  session[:confirm] = ['Your report has been submitted! One of our administrators will review it shortly.']
  redirect "/cities/#{@city.id}"
end
