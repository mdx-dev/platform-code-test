require 'award'

def name_as_sym(name)
   name.is_a?(String) ? name.upcase.gsub(" ","_").to_sym : name
end

def update_quality(awards)
  awards.map {|award| update_award_quality award }
end

def update_award_quality(award)
  new_quality = award.quality + rate_of_change(award)
  respect_limits(Award.new award.name, award.expires_in - 1, (new_quality >= 0 ? new_quality : 0))
end

def respect_limits(award)
  case name_as_sym(award.name)
  when :BLUE_DISTINCTION_PLUS 
    award
  else
    case award.quality
    in 50.. then Award.new award.name, award.expires_in, 50
    in ..-1 then Award.new award.name, award.expires_in, 0
    else award
    end
  end
end

def rate_of_change(award)
  case name_as_sym(award.name)
  when :BLUE_DISTINCTION_PLUS then 0
  when :BLUE_FIRST
    case award.expires_in
      in 1.. then 1 
      else 2 
    end
  when :BLUE_COMPARE
    case award.expires_in
      in 11.. then 1
      in ..0 then award.quality * -1
      in ..5 then 3
      in ..10 then 2
    else 0
    end
  when :BLUE_STAR
    case award.expires_in
     in 1.. then -2
    else -4
    end
  else
    case award.expires_in
      in 1.. then -1
      else -2
    end
  end
end
