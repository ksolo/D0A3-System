FactoryGirl.define do
  factory :spot do
    child { FactoryGirl.create(:person) }
    tutor { FactoryGirl.create(:person) }
    group { FactoryGirl.create(:group) }
  end
end