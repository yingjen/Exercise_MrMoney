class Account < ActiveRecord::Base
    validates_presence_of :buyday, :title, :message => "不能為空值"
    validates_presence_of :dollar, numericality: { only_integer: true }, :message => "只能輸入數字"
    # default_scope -> { order('buyday ASC') }
end
