require 'spec_helper'

describe Payment do

	let(:spot) { FactoryGirl.create(:spot) }

	before do
		@payment = Payment.new( amount: "999", spot_id: spot.id, date: "12/01/2014", scholarship: false )
	end

	subject { @payment }

	it { should respond_to(:amount) }
	it { should respond_to(:spot_id) }
	it { should respond_to(:date) }
	it { should respond_to(:scholarship) }

	it { should be_valid }

	describe "when date is not valid" do
		before { @payment.date = " " }
		it { should_not be_valid }
	end

	describe "when amount is not valid" do
		before { @payment.amount = " " }
		it { should_not be_valid }
	end

	describe "when spot_id is not present" do
		before { @payment.spot_id = nil }
		it { should_not be_valid }
	end

end