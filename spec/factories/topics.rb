FactoryGirl.define do
  factory :topic do
    association :user
    title "Lorem ipsum"

    factory :topic_with_post do
      after(:create) do |topic|
        create(:post, user: topic.user)
      end
    end
  end
end
