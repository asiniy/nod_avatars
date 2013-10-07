class Photo < ActiveRecord::Base

  mount_uploader :avatar, AvatarsUploader
end
