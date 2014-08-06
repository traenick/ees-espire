class User < ActiveRecord::Base
  attr_accessible :api_token, :email_address, :first_name, :last_name

  has_many :message_flows

  def full_name
    self.first_name + ' ' + self.last_name
  end

end
