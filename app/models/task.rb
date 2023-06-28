class Task < ApplicationRecord
    belongs_to :assignee, class_name: 'User'
    belongs_to :approver, class_name: 'User'
    belongs_to :organization
    has_many :comments, as: :commentable, dependent: :destroy
    # validate :validate_assignee_not_organization_admin
    # validate :validate_approver_not_organization_admin
  

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

    # def validate_assignee_not_organization_admin
    #   if assignee&.organization_admin?
    #     errors.add(:assignee_id, 'cannot be an organization admin')
    #   end
    # end

    # def validate_approver_not_organization_admin
    #   if approver&.organization_admin?
    #     errors.add(:approver_id, ' cannot be an organization admin')
    #   end
    # end
  
end
