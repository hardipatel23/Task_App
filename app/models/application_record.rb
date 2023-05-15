class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # before_action :authenticate_user!

  def current_organization
    @current_organization ||= current_user.organization
  end
end
