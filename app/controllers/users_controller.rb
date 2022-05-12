class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    render json: {users: @users}
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    verified = Invite.where(email: user_params[:email]).first
    if verified
      verified.acceepted_at = DateTime.now
      @user.verified=true
    end

    if @user.save
      @token = encode({id:@user.id})
      render json:{
        user: @user.attributes.except("password_digest"),
        token:@token

      }, status: :created
    else

      render json: @user.errors.objects.first.full_message, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def verify
    user_id = params["user_id"]
    user = User.find(user_id)
    if user
      user["verified"] = true
      user.save
    end
    render json: {user_verified: user}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :phone, :skill_level, :is_admin, :emergency_contact_name, :emergency_contact_phone)
    end
end
