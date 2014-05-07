require 'spec_helper'

feature "User browses the list of links" do

	before(:each) {
		Link.create(:url => "http://www.makeracademy.com",
			:title => "Lemon Party")
	}
	
	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Lemon Party")
	end
end