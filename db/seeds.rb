# coding: utf-8;
def create_user(user_hash)
  u = User.where(email: user_hash[:email])
      .first_or_create!(name: user_hash[:name],
                        password: user_hash[:password],
                        password_confirmation: user_hash[:password])
  u.update_attribute(:admin, user_hash[:admin])
end

create_user(name: 'Александр Антонов', email: 'kaburbundokel11g@inbox.ru', password: 'secret', admin: true)
create_user(name: 'Риф Зарипов', email: 'rifzar76@gmail.com', password: 'secret', admin: true)
create_user(name: 'Сергей Бовда', email: 'capoeiristo@gmail.com', password: 'secret', admin: true)
