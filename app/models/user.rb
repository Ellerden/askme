require 'openssl'
require 'unicode'

class User < ActiveRecord::Base
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  has_many :questions
  attr_accessor :password

  validates :email, :username, presence: true
  validates_uniqueness_of :email, :username, case_sensitive: false
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  before_save :encrypt_password
  before_create :downcase_username, :username_ok?, :email_ok?

  #проверка формата email по символам
  def email_ok?
    email_regexp = /^[a-z\d_.\-]+@([a-z\d.\-])+\.[a-z]+$/i
    !!(self.email =~ email_regexp)
  end

  # проверка макс длины юзернейма (не больше 40 символов) и соответсвию симфолов – латиница, цифры, _
  def username_ok?
    username_regexp = /\w{3,40}/i
    !!(self.username =~ username_regexp)
  end

  def encrypt_password
  if self.password.present?

    #соль - рандомная cтрока
    self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

    #хэш пароля
    self.password_hash = User.hash_to_string(
    OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
   )
  end
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
      user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def downcase_username
    self.username.downcase!
  end

end




