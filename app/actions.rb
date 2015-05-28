# Homepage (Root path)
set sessions: true


get '/register' do
  @user = User.new
  erb :'register'
end