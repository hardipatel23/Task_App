class NotificationMailer < ApplicationMailer
  default from: 'your_email@example.com'

  def assignment_notification(task)
    @task = task
    @assignee = @task.assignee
    @organization = @task.organization

    mail(to: @assignee.email, subject: 'Task Assigned Notification')
  end

  def approval_notification(task)
    @task = task
    @approver = @task.approver
    @organization = @task.organization

    mail(to: @approver.email, subject: 'Task Approval Notification')
  end
end
