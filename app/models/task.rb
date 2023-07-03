class Task < ApplicationRecord
    belongs_to :assignee, class_name: 'User'
    belongs_to :approver, class_name: 'User'
    belongs_to :organization
    has_many :comments, as: :commentable, dependent: :destroy

    validates :name, presence: true
    validates :description, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validate :validate_dates
  

    enum status: {
      todo: 'ToDo',
      in_progress: 'In Progress',
      in_review: 'In Review',
      approved: 'Approved',
      rejected: 'Rejected',
      closed: 'Closed'
    }
    
    after_update :send_assignment_notification, if: :saved_change_to_assignee_id?
    after_update :send_approval_notification, if: :saved_change_to_approver_id?

  

  def send_assignment_notification
    NotificationMailer.assignment_notification(self).deliver_now
  end

  def send_approval_notification
    NotificationMailer.approval_notification(self).deliver_now
  end

    private

    # validate :validate_assignee_not_organization_admin
    # validate :validate_approver_not_organization_admin
    # def validate_assignee_not_organization_admin
    #   if assignee&.organization_admin?
    #     errors.add(:assignee_id, 'cannot be an organization admin')
    #   end
    # end

    def validate_dates
      if end_date < start_date
        errors.add(:end_date, 'is not less than start_date')
      end
    end

    # def validate_approver_not_organization_admin
    #   if approver&.organization_admin?
    #     errors.add(:approver_id, ' cannot be an organization admin')
    #   end
    # end
  
end
