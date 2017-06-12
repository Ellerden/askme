module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
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



