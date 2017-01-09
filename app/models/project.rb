class Project < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles

  has_many :conversations

  validates :title,  presence: true
  validates :description,  presence: true
  validates :category,  presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def owner
    User.find_by_id(Role.where(project_id: self, status: "Owner").first.user_id)
  end

  def organization
    Organization.find_by_id(Membership.where(user_id: self.owner).first.organization_id)
  end
end

