ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel "Аватары обновлённые сегодня: #{Photo.published_today.length}" do
          h3 { link_to "Смотреть все #{Photo.count} аватаров", admin_photos_path }
          ul do
            Photo.published_today.each do |photo|
              li image_tag "#{photo.provider_name}_icon.png"
            end
          end
        end
      end
    end
  end
end
