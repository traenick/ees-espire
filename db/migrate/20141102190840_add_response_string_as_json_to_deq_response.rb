class AddResponseStringAsJsonToDeqResponse < ActiveRecord::Migration
  def change
    add_column :deq_responses, :response_string_as_json, :text
  end
end
