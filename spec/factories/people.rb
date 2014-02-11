FactoryGirl.define do
  factory :person do
    name "Fernando"
    sequence(:first_last_name) { |n| "Garcia#{n}" }
    sequence(:second_last_name) { |n| "Hernandez#{n}" }
    sex "M"
    dob "20/01/1995"
    family_roll "Hijo"

    trait :random_date do
        dob "01/01/2014"
    	#dob { rand(4.years).ago }
    end

  end

end