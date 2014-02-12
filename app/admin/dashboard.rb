ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel link_to "Смотреть все #{Photo.count} аватаров", admin_photos_path do
          h3 "Аватары обновлённые сегодня: #{Photo.published_today.length}"
          ul do
            Photo.published_today.each do |photo|
              li "#{social_network_icon(photo)} #{photo.username}".html_safe
            end
          end
        end
      end
    end
  end
end
