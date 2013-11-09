unless Artist.any?
  wonder_bars = Artist.create name: "The Wonder Bars"
  rnd = Artist.create name: "Research & Development"
  subatomica = Artist.create name: "Subatomica"
end

unless Release.any?
  just_the_start = wonder_bars.releases.create \
    name: "Just The Start EP",
    released_on: 2.years.ago.to_date,
    description: "Debut from Philly's favorite house band",
    catalog_number: 'WXP001'
  shuffle_not = rnd.releases.create \
    name: "Shuffle Not EP",
    released_on: 1.month.ago.to_date,
    description: "Debut from the mythical and mysterious R&D",
    catalog_number: 'WXP002F'
  cloud_shadows = subatomica.releases.create \
    name: "Cloud Shadows EP",
    released_on: 1.month.from_now.to_date,
    description: "The long-awaited remix EP of this amazing track",
    catalog_number: 'WXP003'
end

unless Product.any?
  just_the_start.products.create \
    name: "Just The Start (WAV download)",
    price: 3.99
  shuffle_not.products.create \
    name: "Shuffle Not (WAV download)",
    price: 3.99
  cloud_shadows.products.create \
    name: "Cloud Shadows (WAV download)",
    price: 4.99
  shuffle_not.products.create \
    name: "Shuffle Not (Open-Source Edition)",
    price: 9.99
end

unless User.any?
  User.create! \
    email: 'customer@example.com',
    password: 'customer',
    password_confirmation: 'customer'

  User.create! \
    email: 'admin@waxpoeticrecords.com',
    password: 'password',
    password_confirmation: 'password',
    is_admin: true
end
