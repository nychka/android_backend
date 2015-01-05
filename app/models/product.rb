class Product < ActiveRecord::Base
  multilang :title
  belongs_to :group
  belongs_to :user
  self.per_page = 10

  default_scope { order('created_at desc') }
  scope :system,      ->{ where('user_id = 0') }
  scope :system_with_owner, ->(user_id){ where('user_id = 0 OR user_id = ?', user_id) }
  scope :by_users,    ->{ where('user_id > 0') }

  def owner
    user_id && user_id > 0
  end

  def self.search(search)
    if search
      where('CAST(avals(title) AS text) LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end
  def self.show(show)
    case show
      when 'system'
        self.system
      when 'by_users'
        self.by_users
      else
        where(nil)
    end
  end
end
