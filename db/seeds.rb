unless AdminUser.where(email: 'admin@example.com').any?
  AdminUser.create \
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
end

unless Artist.any?
  wonder_bars = Artist.create name: "The Wonder Bars"
  rnd = Artist.create name: "Research & Development"
  subatomica = Artist.create name: "Subatomica"

  just_the_start = wonder_bars.releases.build \
    name: "Just The Start EP",
    released_on: 2.years.ago.to_date,
    description: "Debut from Philly's favorite house band"
  shuffle_not = rnd.releases.build \
    name: "Shuffle Not EP",
    released_on: 1.month.ago.to_date,
    description: "Debut from the mythical and mysterious R&D"
  cloud_shadows = subatomica.releases.build \
    name: "Cloud Shadows EP",
    released_on: 1.month.from_now.to_date,
    description: "The long-awaited remix EP of this amazing track"

  if just_the_start.save && shuffle_not.save && cloud_shadows.save
    shuffle_not_wavs = shuffle_not.products.create \
      name: "WAV download",
      price: 3.99
    cloud_shadows_wavs = cloud_shadows.products.create \
      name: "WAV download",
      price: 9.99
    shuffle_not_ose = shuffle_not.products.create \
      name: "Open-Source",
      price: 9.99

    raise "whoops!" unless shuffle_not_wavs && cloud_shadows_wavs && shuffle_not_ose
  end
end

