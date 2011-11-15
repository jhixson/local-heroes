class UserSession < Authlogic::Session::Base
  logout_on_timeout false

  #params_key :api_key
	#single_access_allowed_request_types :any

  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end


