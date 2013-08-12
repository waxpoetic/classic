ActiveAdmin.register Artist do
  index do
    column :name
    default_actions
  end

  form do |f|
    f.inputs :name, :cover_image, :description, :members
  end
end
