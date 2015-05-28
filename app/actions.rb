
# Homepage (Root path)
set sessions: true


get '/register' do
  @user = User.new
  erb :'register'
end

post '/register' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
    )
  @user.errors.add[:password, "fields must match!"] if params[:password] != params[:password_confirm]
  if @user.save
    redirect '/register'
  else
    erb :'/register'
  end
end