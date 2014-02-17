require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_link('Sign in',    href: signin_path) }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Sign in" }

        it { should_not have_content('div.alert.alert-error') }

      end
    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_link('Sign out',    href: signout_path) }
      it { should have_link('Familias',    href: families_path) }
      it { should have_link('Grupos',      href: groups_path) }
      it { should have_link('Home',        href: root_path) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signout_path ) }

    end

  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

      end
    end
  end
end