class API::V1::SessionsController < API::BaseController

  def create
    user = User.find_by_credentials(params[:email], params[:password])
    if user
      token = user.generate_auth_token
      render(
        json: { message: "User logged in", auth_token: token },
        status: 200
      )
    else
      render(
        json: { message: "Unauthorized" },
        status: 422
      )
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
