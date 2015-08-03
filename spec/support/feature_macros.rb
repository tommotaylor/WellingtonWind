def sign_in
  Fabricate(:user, email: "tom@tom.com", password: "password")
  visit sign_in_path
  fill_in 'email', with: "tom@tom.com"
  fill_in 'password', with: "password"
  click_button 'Sign In'
end