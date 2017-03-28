module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def log_in(user)
    visit root_path
    click_link "Log in"
    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
