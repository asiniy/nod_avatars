class Photo < ActiveRecord::Base
  include VKPhoto

  mount_uploader :avatar, AvatarsUploader

  scope :published, -> { where(published: true) }

  validates :provider_uid, :provider_name, :username, presence: true
end
