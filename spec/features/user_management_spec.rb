require 'spec_helper'

feature "User signs up" do 

	scenario "when being logged out" do
		lambda { sign_up }.should change(User, :count).by(1)
		expect(page).to have_content("Welcome, johndoe@example.com")
		expect(User.first.email).to eq("johndoe@example.com")
	end

	def sign_up(email = "johndoe@example.com",
				password = "penislol")
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :email, :with => email
		fill_in :password, :with => password
		click_button "Sign up"
	end

end