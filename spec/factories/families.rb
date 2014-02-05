FactoryGirl.define do
  factory :family do
    sequence(:name)  { |n| "Family#{n}" }
    status true
    observations "Esta es una observación de la Familia Perez Lopez"

    trait :pasiva do
    	status false
    end
  end
end