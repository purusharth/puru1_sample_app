require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end 
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  # Chapter 10 Exercise 2 
  describe "micropost pagination" do
    before { visit root_path }
    before { 49.times { FactoryGirl.create(:micropost, user: user) } }
    after  { user.microposts.delete_all }

    it "should have 49 microposts" do
    	visit root_path
  		expect(page).to have_selector('span', text: '49 microposts')
  		expect(page).to have_selector('div.pagination') # check for pagination tag
  	end

    it "should list each micropost" do
    	visit root_path
        user.microposts.paginate(page: 1).each do |micropost| #verify each micropost on pg 1
          expect(page).to have_selector('li', text: micropost.content)
        end
    end
  end

  # Chapter 10 Exercise 1
  describe "sidebar micropost counts" do
  	before { visit root_path}
  	before { user.microposts.delete_all }

  	it "should have 0 microposts" do
  		expect(page).to have_selector('span', text: '0 microposts')
  	end

  	it "should have 1 micropost" do
  		FactoryGirl.create(:micropost, user: user)
  		visit root_path
  		expect(page).to have_selector('span', text: '1 micropost')
  		expect(page).not_to have_selector('span', text: '1 microposts')
  	end

    it "should have 2 microposts" do
  	    2.times {FactoryGirl.create(:micropost, user: user)}
  		visit root_path
  		expect(page).to have_selector('span', text: '2 microposts')
  	end
  end
end