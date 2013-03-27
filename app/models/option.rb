class Option < ActiveRecord::Base
  attr_accessible :key, :value_type, :string_value, :text_value, :int_value

  def get_value
    if value_type == "String"
      return string_value
    elsif value_type == "Integer"
      return int_value
    else
      return text_value
    end
  end
end
