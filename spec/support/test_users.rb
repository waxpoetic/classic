module TestUsers
  def customer_user
    @customer_user = find_or_create_user \
      email: 'lester.tester@example.com',
      password: 'example123',
      password_confirmation: 'example123'
  end

  def admin_user
    @admin_user ||= find_or_create_user \
      email: 'tech.support@waxpoeticrecords.com',
      password: 'example123',
      password_confirmation: 'example123',
      is_admin: true
  end

  # Ghetto fixture
  def users type
    send "#{type}_user"
  rescue NoMethodError
    raise "#{type} user is not defined in spec/support/test_users.rb"
  end

  private
  def find_or_create_user with_attributes
    found_users = User.where email: with_attributes[:email]
    return found_users.first if found_users.any?
    User.create! with_attributes
  end
end
