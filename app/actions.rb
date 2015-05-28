# Homepage (Root path)
set sessions: true

helpers do

  def is_user?
    @current_user != nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
  end

end

get '/' do
  erb :index
end

get '/tracks' do
  # "To Do"
  @tracks = Track.all
  @tracks = @tracks.order("upvote_count DESC")
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb (current_user ? :'tracks/new' : :'register')
end

get '/logout' do
  session.clear
  @current_user = nil
  redirect '/tracks'
end

get '/register' do
  @user = User.new
  erb :'register'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/details'
end

post '/register' do
  email = params[:email]
  password = params[:password]
  name = params[:name]
  @user = User.new(email: email, name: name, password: password)
  if @user.save
    login(@user)
    redirect '/tracks'
  else
    erb :'register'
  end
end
post '/tracks' do
  @track = current_user.tracks.new(
    song_title: params[:song_title],
    artist: params[:artist],
    url: params[:url]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

post '/login' do
  email = params[:email]
  password = params[:password]
  user = User.find_by(email: email, password: password)
  login(user) if user
  redirect '/tracks'
end

post '/upvote' do
  track_id = params[:track_id]
  current_user.upvotes.create(track_id: track_id)
  redirect '/tracks'
end

post '/downvote' do
  track_id = params[:track_id]
  current_user.upvotes.find_by(track_id: track_id).delete
  redirect '/tracks'
end

post '/review' do
  track_id = params[:track_id]
  content = params[:content]
  review = current_user.reviews.new(content: content, track_id: track_id)
  if review.save
    redirect "/tracks/#{track_id}"
  end
end

post '/review/delete' do
  track_id = params[:track_id]
  review_id = params[:review_id]
  current_user.reviews.delete(review_id)
  redirect "/tracks/#{track_id}"
end