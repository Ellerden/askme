class Question < ActiveRecord::Base
  belongs_to :user
  validates :text, :user, presence: true

  def lenght_ok?(text)
    text_regexp = /.{1,255}/i
    !!(text =~ text_regexp)
  end

end
