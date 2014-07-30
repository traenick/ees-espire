class User < ActiveRecord::Base
  attr_accessible :api_token, :email_address, :first_name, :last_name
end
