class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  belongs_to :organization
  
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum role: {organization_admin: 0, user: 1}
end
