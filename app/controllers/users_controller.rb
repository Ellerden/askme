class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Ура! Регистрация прошла успешно!'
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Dasha',
      username: 'cardu',
      avatar_url: 'http://www.hbw.com/sites/default/files/styles/large_a/public/figures/hbw16/jpg/16_27_232_Euphonia_anneae_m.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('02.06.2017')),
      Question.new(text: 'Как пройти в библиотеку?', created_at: Date.parse('02.06.2017')),
    ]

    @declension = declension(@questions.count, "вопрос", "вопроса", "вопросов")
    @new_question = Question.new
  end


  private

  def user_params
    params.require(:user).permit(:email, :username, :name, :password, :password_confirmation, :avatar_url)

  end

  def declension(number, word_form1, word_form2, word_form3)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    excess = number % 100

    if excess >= 11 && excess <= 14
      return word_form3
    end

    excess = number % 10

    if excess == 1
      return word_form1
    end

    if excess >= 2 && excess <= 4
      return word_form2
    end

    if excess == 0 || (excess >= 5 && excess <= 9)
      return word_form3
    end
  end

end
