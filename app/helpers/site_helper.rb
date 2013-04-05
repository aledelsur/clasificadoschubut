module SiteHelper
  def set_currency(currency)
    if currency == "pesos"
      "$"
    elsif currency == "dolares" 
      "U$D"
    end
  end

  def set_collapse_number(index)
    if index == 0
      "collapseOne"
    elsif index == 1
      "collapseTwo"
    elsif index == 2
      "collapseThree"
    elsif index == 3
      "collapseFour"
    elsif index == 4
      "collapseFive"
    elsif index == 5
      "collapseSix"
    elsif index == 6
      "collapseSeven"
    end
  end

end
