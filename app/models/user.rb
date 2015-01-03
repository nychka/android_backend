class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products
  belongs_to  :role

  def role
    Role.find(role_id).role.to_sym if role_id
  end
  def role? role
    role = Role.find_by_role(role.to_s)
    role_id == role.try(:id)
  end
end
