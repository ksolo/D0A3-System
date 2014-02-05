require 'spec_helper'

describe Spot do

	let(:child) { FactoryGirl.create(:user) }
	let(:tutor) { FactoryGirl.create(:user) }
	let(:group) { FactoryGirl.create(:group) }

	before do
		@spot = Spot.new( child_id: child.id, tutor_id: tutor.id, group_id: group.id )
	end

	subject { @spot }

	it { should respond_to(:child_id) }
	it { should respond_to(:group_id) }
	it { should respond_to(:tutor_id) }

	it { should be_valid }

	describe "when attribute is not present" do

		before do
			@spot.child_id = nil
			@spot.tutor_id = nil
			@spot.group_id = nil
		end

		it { should have(1).error_on(:child_id) }
		it { should have(1).error_on(:tutor_id) }
		it { should have(1).error_on(:group_id) }

	end

end