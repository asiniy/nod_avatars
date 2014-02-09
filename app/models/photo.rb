class Photo < ActiveRecord::Base
  mount_uploader :avatar, AvatarsUploader

  validates :provider_uid, :provider_name, :username, presence: true

  scope :published, -> { where(published: true) }
end
