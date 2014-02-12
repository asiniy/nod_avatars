ActiveAdmin.register Photo do
  index do
    column :username do |photo|
      link_to photo.username, social_network_url(photo)
    end
    column :provider_name do |photo|
      social_network_icon(photo)
    end
    column :avatar do |photo|
      image_tag photo.avatar_url(:site)
    end
  end

  filter :provider_name
  filter :username
end
