FactoryGirl.define do
  factory :spot do
    child { FactoryGirl.create(:person) }
    tutor { FactoryGirl.create(:person) }
    group
  end
end