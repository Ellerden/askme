require 'openssl'
# gem "openssl"

class User < ActiveRecord::Base

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions
  attr_accessor :password
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password


  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
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

end

