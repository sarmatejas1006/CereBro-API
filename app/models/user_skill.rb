class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  validates :user_id, uniqueness: { scope: :skill_id }, presence: true
  validates :skill_id, presence: true
end
