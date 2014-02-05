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
		describe 'Should render people list' do
			it "should list each person" do
				Person.all.each do |member|
					expect(page).to have_selector('a', text: member.name)
				end
			end
		end
	end
end