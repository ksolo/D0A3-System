FactoryGirl.define do
  factory :group do
    name "Primer Clase"
    cost "280"
    user { FactoryGirl.create(:user) }
    init_date "10/01/1995"
    finish_date "20/01/1995"
    min_age "3"
    max_age "12"
    location "Aula uno"
  end
end