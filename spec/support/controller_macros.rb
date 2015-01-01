module ControllerMacros
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    sign_in user
    user
  end
  def format_data items
    items.map {|item| format_item(item) }.reverse!
  end
  def format_item item
    item.as_json.delete_if{|k,v|k == 'created_at' || k == 'updated_at'}
  end
end