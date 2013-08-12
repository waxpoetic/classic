ActiveAdmin.register Release do
  index do
    column :name
    column :artist
    column :released_on
  end

  form do |f|
    f.inputs :name, :cover_image, :artist, :released_on, :tracks
    f.actions
  end
end
