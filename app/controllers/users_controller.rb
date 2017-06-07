class UsersController < ApplicationController
  def index
    @users = [
      User.new(
      id: 1,
      name: 'Dasha',
      username: 'cardu',
      avatar_url: 'http://www.hbw.com/sites/default/files/styles/large_a/public/figures/hbw16/jpg/16_27_232_Euphonia_anneae_m.jpg'
      ),
      User.new(
        id: 2,
        name: 'Ira',
        username: 'charbon',
        avatar_url: 'http://www.hbw.com/sites/default/files/styles/large_a/public/figures/hbw16/jpg/16_27_232_Euphonia_anneae_m.jpg'
      )
    ]
  end

  def new
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

    @new_question = Question.new
  end
end
