FactoryGirl.define do
  factory :post do
    user { @user = create(:user) }
    topic { @topic = create(:topic, user: @user) }

    content %q[
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
    ]
  end
end
