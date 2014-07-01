User.destroy_all

u1 = User.create(:username => 'Ros', :avatar => 'http://upload.wikimedia.org/wikipedia/commons/f/f9/French_Bulldog_-_Bouledogue_Fran%C3%A7ais.jpg', :password => 'password', :password_confirmation => 'password', :is_admin => true)
u2 = User.create(:username => 'Bill', :avatar => 'http://upload.wikimedia.org/wikipedia/commons/f/f9/French_Bulldog_-_Bouledogue_Fran%C3%A7ais.jpg', :password => 'password', :password_confirmation => 'password')
u3 = User.create(:username => 'Xaun', :avatar => 'http://upload.wikimedia.org/wikipedia/commons/f/f9/French_Bulldog_-_Bouledogue_Fran%C3%A7ais.jpg', :password => 'password', :password_confirmation => 'password')