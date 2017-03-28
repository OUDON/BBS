FactoryGirl.define do
  factory :topic do
    association :user
    title "Lorem ipsum"
  end
end
