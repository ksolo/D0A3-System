FactoryGirl.define do
  factory :person do
    name "Fernando"
    sequence(:first_last_name) { |n| "Garcia#{n}" }
    sequence(:second_last_name) { |n| "Hernandez#{n}" }
    sex "M"
    dob "20/01/1995"
    family_roll "Hijo"
  end
end