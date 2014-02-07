require 'spec_helper'

describe 'Person pages' do
	subject { page }

	let(:user) { create(:user) }

  	before do
  		sign_in user
  		10.times { create(:person) }
		visit people_path
	end

	describe 'Index People' do
		it { should have_title('Todos los Miembros') }
		it { should have_content(Person.all.count) }
		describe 'Should render people list' do
			it "should list each person" do
				Person.all.each do |member|
					expect(page).to have_selector('a', text: member.name)
				end
			end
		end
	end

	describe 'Show user information' do
		let(:member) { FactoryGirl.create(:person) }
		before { visit person_path(member) }
		it { should have_title(member.name) }
	end

end