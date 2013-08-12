ActiveAdmin.register Release do
  index do
    column :name
    column :artist
    column :catalog_number
    column :released_on
    default_actions
  end

  form do |f|
    f.inputs :name, :cover_image, :artist, :released_on, :tracks,
             :catalog_number
    f.actions
  end
end
