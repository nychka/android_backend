module ControllerMacros
  def login_user(role)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(role)
    sign_in user
    user
  end
end