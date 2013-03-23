class AddMoreErrorTrace < ActiveRecord::Migration
  def change
    add_column :error_traces, :source_code, :text
    add_column :error_traces, :url, :text
    add_column :error_traces, :params, :text
    add_column :error_traces, :action, :text
    add_column :error_traces, :environment, :text
    add_column :error_traces, :context, :text
    add_column :error_traces, :cookies, :text
    add_column :error_traces, :remote_ip, :text
    add_column :error_traces, :browser, :text
  end
end
