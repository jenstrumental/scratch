class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name

  has_many :transactions, :foreign_key => "debitee_id"
  has_many :transactions, :foreign_key => "creditee_id"

  validates_numericality_of :balance, :only_integer => true, :greater_than_or_equal_to => 0


  BETA_FBUIDS = [1218195 #jen
  				]

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end

  def has_beta_access?
  	self.provider == "facebook" && BETA_FBUIDS.include?(self.uid)
  end

  def credit(amount)
    self.balance += amount
    self.save!
  end

  def debit(amount)
    self.balance -= amount
    self.save!
  end
end
