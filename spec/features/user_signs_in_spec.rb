require 'rails_helper'

feature "user signs in"  do
  background do
    Fabricate(:user, email: "tom@tom.com", password: "password")
  end
  scenario "with correct credentials" do
    visit sign_in_path
    fill_in 'email', with: "tom@tom.com"
    fill_in 'password', with: "password"
    click_button 'Sign In'
    expect(page).to have_content('Welcome, ' + User.first.name)
  end
  scenario "with incorrect credentials" do
    visit sign_in_path
    fill_in 'email', with: "tom@tom.com"
    fill_in 'password', with: "pass"
    click_button 'Sign In'
    expect(page).to have_content('There is something wrong with your username or password.')    
  end
end