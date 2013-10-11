
# Find User object by ID or current_user

module UserFinder
  def find_or_set_user
    @user ||= begin
      user_from_params || current_user
    end

    binding.pry
  end

  private
  def user_from_params
    User.find user_id
  end

  def user_id
    params[:id] || params[:user_id]
  end
end
