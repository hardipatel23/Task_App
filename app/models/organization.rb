class Organization < ApplicationRecord
    has_many :user_organizations, dependent: :destroy
    has_many :users, through: :user_organizations
    has_many :tasks
    accepts_nested_attributes_for :users, allow_destroy: true
end
