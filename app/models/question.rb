class Question < ActiveRecord::Base
  belongs_to :user
  validates :text, :user, presence: true
  validate :length_ok?

  def length_ok?
    text_regexp = /.{5,255}/i
    if !(self.text =~ text_regexp)
      @errors.add(:text, "should be up to 255 characters")
    end
  end

end
