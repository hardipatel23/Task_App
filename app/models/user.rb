class User < ApplicationRecord

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,:authentication_keys => [:username]

  enum role: {organization_admin: 0, user: 1} 

  # belongs_to :organization, optional: true

  has_many :user_organizations, dependent: :destroy
  has_many :organizations, through: :user_organizations
  
  belongs_to :current_organization, class_name: 'Organization', optional: true

  has_many :comments, foreign_key: 'user_id', dependent: :destroy

  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: :destroy
  has_many :approved_tasks, class_name: 'Task', foreign_key: 'approver_id', dependent: :destroy

  before_validation :generate_password
  after_create :send_password_reset_email
  validate :unique_organization_admin, if: :organization_admin?
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  def send_password_reset_email
    # send_reset_password_instructions
    UserMailer.welcome_reset_password_instructions(self).deliver_now 
  end

  private

  def unique_organization_admin
    if organizations.present? && organizations.any? { |org| org.users.exists?(role: 'organization_admin') && org.users.where(role: 'organization_admin').where.not(id: id).exists? }
      errors.add(:role, 'Organization admin already exists for this organization')
    end
  end


    #random password
    def generate_password
      self.password = SecureRandom.hex(8) if self.new_record? 
    end
  
end
