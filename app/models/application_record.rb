class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def current_organization
    @current_organization ||= current_user.organization
  end
end
