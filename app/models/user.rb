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

  validates_presence_of :name 

  BETA_FBUIDS = [1218195 #jen
  				]


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    puts "------------------------------------------- provider: #{auth.provider}"
    puts "------------------------------------------- auth.uid: #{auth.uid}"
    user = User.where(:provider => auth.provider, :uid => auth.uid.to_i).first
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

  def transfers
    Transaction.where("creditee_id = #{self.id} or debitee_id = #{self.id}").where(:type => "Transfer")
  end

end
