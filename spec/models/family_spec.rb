require 'spec_helper'

describe Family do

	before do
		@family = Family.new(name: "Perez Lopez")
	end

	subject { @family }

	it { should respond_to(:name) }

	it { should be_valid }

	describe "when name is not present" do
		before { @family.name = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @family.name = "a" * 61 }
		it { should_not be_valid }
	end


	describe "when name address is already taken" do
		before do
			family_with_same_name = @family.dup
			family_with_same_name.name = @family.name.upcase
			family_with_same_name.save
		end

		it { should_not be_valid }
	end

end