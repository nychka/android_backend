class Product < ActiveRecord::Base
  multilang :title
  belongs_to :group
  belongs_to :user

  default_scope { order('created_at desc') }
  scope :system,      ->{ where('user_id = 0') }
  scope :system_with_owner, ->(user_id){ where('user_id = 0 OR user_id = ?', user_id) }
  scope :by_users,    ->{ where('user_id > 0') }

  def owner
    user_id && user_id > 0
  end
end
