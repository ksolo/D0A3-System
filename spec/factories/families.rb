# encoding: UTF-8
FactoryGirl.define do
  factory :family do
    sequence(:name)  { |n| "Family#{n}" }
    status true
    observations "Esta es una observacion de la Familia Perez Lopez"
  end
end