class Photo < ActiveRecord::Base
  include VKPhoto

  mount_uploader :avatar, AvatarsUploader

  scope :published, -> { where(published: true) }

  validates :provider_uid,
            presence: true

  validates :provider_name,
            presence: true

  validates :username,
            presence: true
end
