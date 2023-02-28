require 'award'

def update_quality(awards)
  awards.each do |award|
    rule = reward_rules[award.name] # load rule for award
    award.quality += rule[:rate] # Apply basic rate
    award.expires_in += rule[:expire_rate] # Apply expiration rate
    rule[:modifiers]&.each do |mod|
      if mod[:time_left] > award.expires_in # Modifiers sorted by time left and after first available will fit condition, we will skip other
        award.quality += mod[:rate] # Apply special quality rate
        break # skip rest modifiers
      end
    end

    award.quality = rule[:max_quality] if award.quality > rule[:max_quality] # if quality become greater then max quality, we reset to max value
    award.quality = rule[:min_quality] if award.quality < rule[:min_quality] # same as max, just for min value
  end
end

def reward_rules
  {
    'NORMAL ITEM' => {
      rate: -1, # Basic quality rate
      expire_rate: -1, # Expiration rate
      max_quality: 50, # Max posible quality
      min_quality: 0, # Min possible quality
      modifiers: [ # Special rules depends on time left
        {time_left: 0, rate: -1}
      ]
    },
    'Blue First' => {
      rate: +1,
      expire_rate: -1,
      max_quality: 50,
      min_quality: 0,
      modifiers: [
        {time_left: 0, rate: +1}
      ]
    },
    'Blue Distinction Plus' => {
      rate: 0,
      expire_rate: 0,
      max_quality: 80,
      min_quality: 80
    },
    'Blue Compare' => {
      rate: +1,
      expire_rate: -1,
      max_quality: 50,
      min_quality: 0,
      modifiers: [
        {time_left: 0, rate: -99}, # Nulify quality if it reach 0
        {time_left: 5, rate: +2},
        {time_left: 10, rate: +1}
      ]
    },
    'Blue Star' => {
      rate: -2,
      expire_rate: -1,
      max_quality: 50,
      min_quality: 0,
      modifiers: [
        {time_left: 0, rate: -2}
      ]
    },
  }
end