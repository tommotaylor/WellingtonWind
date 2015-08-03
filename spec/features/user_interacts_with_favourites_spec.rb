require 'rails_helper'

feature "user interacts with favourites" do
  scenario "user adds and reorders favourites" do

    windsurfing = Fabricate(:category, name: 'windsurfing')
    spot1 = Fabricate(:spot, name: 'Worser Bay', :categories => Category.where(name: 'windsurfing'), latitude: -41.313107, longitude: 174.828204)
    spot2 = Fabricate(:spot, name: 'Seatoun', :categories => Category.where(name: 'windsurfing'), latitude: -41.322959, longitude: 174.835677)

    sign_in
    assert_signed_in

    find_and_click(spot1)
    assert_favourites_page(spot1)

    visit home_path
    assert_link_gone(spot1)

    find_and_click(spot2)
    assert_favourites_page(spot2)

    change_favourites_order(spot1, 2)
    expect_spot_position(spot1, 2)
  end

  def assert_signed_in
    expect(page).to have_content('Welcome, ' + User.first.name)
  end

  def find_and_click(spot)
    find("a[href='/favourites?spot_id=#{spot.id}']").click
  end

  def assert_favourites_page(spot)
    expect(page).to have_content('My Favourites')
    expect(page).to have_content(spot.name)
  end

  def assert_link_gone(spot)
    expect(page).to_not have_link('+ My Favourites', :href=>"/favourites?spot_id=#{spot.id}")
  end

  def change_favourites_order(spot, position)
    fill_in "spot_id_#{spot.id}", with: position
    find_button('Update Favourites').click
  end

  def expect_spot_position(spot, position)
    expect(find("#spot_id_#{spot.id}").value).to eq("#{position}")
  end
end