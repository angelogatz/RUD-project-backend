class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  before_action :set_user, only: [:find_users]

  # GET /user
  def index
    @user = User.all
    render json: @user, each_serializer: UserSerializer
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Usuário não encontrado" }, status: :not_found
  end

  # GET /user/1
  def find_users
    render json: @user, serializer: UserSerializer
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Usuário não encontrado" }, status: :not_found
  end

  # POST /user
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: "Invalid credentials" }
    end
  end

  # PATCH/PUT /user/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user/1
  def destroy
    @user.destroy!
  end

  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: "Invalid credentials" }
    end
  end

  def auto_login
    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:username, :password, :age, :email, :permission)
  end

end
