require 'spec_helper'

describe "Family pages" do

  subject { page }

  describe "index" do
    let(:user) { create(:user) }
    before(:each) do
      sign_in user
      10.times {create(:family)}
      visit families_path
    end

    it { should have_title('Nuestras Familias') }
    it { should have_link("Nueva Familia", href: new_family_path)}
    
    describe "Family List" do
      it "should list each family" do
        Family.all.each do |family|
          expect(page).to have_link(family.name, href: family_path(family))
          expect(page).to have_selector('a', text: family.name)
        end
        Family.delete_all
      end
    end
  end # describe index
end #describe-Family pages

