require 'spec_helper'

feature "User signs up" do

  scenario "when being logged out" do
    lambda { sign_up }.should change(User, :count).by(1)
    expect(page).to have_content("Welcome, johndoe@example.com")
    expect(User.first.email).to eq("johndoe@example.com")
  end

  def sign_up(email = "johndoe@example.com",
              password = "penislol",
              password_confirmation = "penislol")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

  scenario "with a password that doesn't match" do
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0)
  end

  def sign_up(email = "johndoe@example.com",
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

  scenario "with a assword that doesn't match" do 
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("GET GOOD AT PASSWORDS. >:C")
end

end
