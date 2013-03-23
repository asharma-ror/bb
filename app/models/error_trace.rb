class ErrorTrace < ActiveRecord::Base
  belongs_to :error
  attr_accessible :application, :full, :source_code, :url, :params, :action, :environment, :context, :cookies, :remote_ip, :browser

  serialize :application, Array
  serialize :full, Array
  serialize :source_code, Hash
  serialize :params, Hash
  serialize :environment, Hash
  serialize :context, Hash
  serialize :cookies, Hash

end
