require 'spec_helper'

describe Person do

	before do
		@person = Person.new(name: "Fernando", first_last_name:"Perez", second_last_name:"Lopez", 
													sex:"M", dob:"20/01/1995", family_roll: "Hijo")
	end

	subject { @person }

	it { should respond_to(:name) }
	it { should respond_to(:first_last_name) }
	it { should respond_to(:second_last_name) }
	it { should respond_to(:sex) }
	it { should respond_to(:dob) }
	it { should respond_to(:family_roll) }
	it { should respond_to(:family_relations) }
	it { should respond_to(:families) }


	it { should be_valid }

	describe "when name is not present" do
		before { @person.name = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @person.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when first_last_name is not present" do
		before { @person.first_last_name = " " }
		it { should_not be_valid }
	end

	describe "when first_last_name is too long" do
		before { @person.first_last_name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when second_last_name is not present" do
		before { @person.second_last_name = " " }
		it { should_not be_valid }
	end

	describe "when second_last_name is too long" do
		before { @person.second_last_name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when sex is not present" do
		before { @person.sex = " " }
		it { should_not be_valid }
	end

	describe "when dob is not present" do
		before { @person.dob = " " }
		it { should_not be_valid }
	end

	describe "when family_roll is not present" do
		before { @person.family_roll = " " }
		it { should_not be_valid }
	end


	describe "when complete name is already taken" do
		before do
			person_with_same_complete_name = @person.dup
			person_with_same_complete_name.name = @person.name.upcase
			person_with_same_complete_name.first_last_name = @person.first_last_name.upcase
			person_with_same_complete_name.second_last_name = @person.second_last_name.upcase
			person_with_same_complete_name.save
		end

		it { should_not be_valid }
	end

end