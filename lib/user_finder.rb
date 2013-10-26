
# Find User object by ID or current_user

module UserFinder
  def find_or_set_user
    @user ||= begin
      user_from_params || current_user
    end
  end

  private
  def user_from_params
    User.find params[:user_id]
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
