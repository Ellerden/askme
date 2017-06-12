class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже зашли на сайт' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже зашли на сайт' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Ура! Регистрация прошла успешно!'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Ура! Данные обновлены!'
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
  end


  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:email, :username, :name, :password, :password_confirmation, :avatar_url)
  end

  def load_user
    @user ||= User.find params[:id]
  end
end
