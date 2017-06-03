class Question < ActiveRecord::Base

  belongs_to :user

  # НЕ РАБОТАЕТ(

  validates :text, :user, presence: true



  # after_validation :after_validation
  #   before_validation :before_validation
  # before_save :before_save
  # after_save :after_save
  # before_create :before_create
  # after_create :after_create
  #
  #
  # before_update :before_update
  # after_update :after_update
  #
  # before_destroy :before_destroy
  # after_destroy :after_destroy
  #
 #  private
 #  #
 #
 #
 #
 #
 #  ['validation', 'save', 'create', 'update', 'destroy'].each do |action|
 #   ['before', 'after'].each do |time|
 # define_method("#{time}, #{action}") do
 #     puts "-------> #{time} #{action}"
 #     end
 #  end
 # end


end
