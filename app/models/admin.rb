class Admin < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  validates_presence_of     :name
  validates_presence_of     :password,                   :on => :create
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  before_save :encrypt_password

  def self.authenticate(name, password)
    # u = find_by_login(name) # need to get the salt
    # u && u.authenticated?(password) ? u : nil
    u = find_by_name(name)
    u && u.authenticated?(password) ? u : nil
  end

  def authenticated?(password)
   password_hash == encrypt(password)
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  protected
    # before filter
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{name}--") if new_record?
      self.password_hash = encrypt(password)
    end
    def password_required?
      password.present?
    end
end
