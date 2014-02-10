class Photo < ActiveRecord::Base
  mount_uploader :avatar, AvatarsUploader

  validates :provider_uid, :provider_name, :username, presence: true

  scope :published, -> { where(published: true) }
  scope :published_today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now) }
end
