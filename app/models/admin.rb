class Admin < User
  default_scope where(:admin => true)
  # attr_accessible :name, :password, :password_confirmation, :admin
  
  # attr_accessor :password
  before_save :encrypt_password, :admin_must_be_set_to_true

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def admin_must_be_set_to_true
    admin = true
  end
end