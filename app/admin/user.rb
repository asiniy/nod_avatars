ActiveAdmin.register User do
  index do
    column :name
    column :email
    bool_column :admin
    default_actions
  end

  show do
    attributes_table do
      row :email
      row :name
      bool_row :admin
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :admin
      f.actions
    end
  end

  filter :email
  filter :name
end
