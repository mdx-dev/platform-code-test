# frozen_string_literal: true

class Award
  BLUE_FIRST = 'Blue First'
  BLUE_COMPARE = 'Blue Compare'
  BLUE_DISTINCT_PLUS = 'Blue Distinction Plus'
  NORMAL_ITEM = 'NORMAL ITEM'
  BLUE_STAR = 'Blue Star'
  MAX_AWARD_VALUE = 50
  TEN_DAYS = 10
  FIVE_DAYS = 5

  attr_reader :name
  attr_accessor :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    decrement_expiration if @name != BLUE_DISTINCT_PLUS

    case @name
    when NORMAL_ITEM
      update_normal
    when BLUE_FIRST
      update_blue_first
    when BLUE_COMPARE
      update_blue_compare
    when BLUE_STAR
      update_blue_star
    end
  end

  private

  def update_blue_star
    @quality = [@quality - 2, 0].max
    @quality = [@quality - 2, 0].max if negative_expires_in?
  end

  def update_blue_compare
    if @quality < MAX_AWARD_VALUE
      increment_quality
      increment_quality if @expires_in <= TEN_DAYS
      increment_quality if @expires_in <= FIVE_DAYS
    end
    reset_quality if negative_expires_in?
  end

  def update_blue_first
    return unless @quality < MAX_AWARD_VALUE

    increment_quality
    @quality = [@quality + 1, MAX_AWARD_VALUE].min if negative_expires_in?
  end

  def update_normal
    @quality = [@quality - 1, 0].max
    @quality = [@quality - 1, 0].max if negative_expires_in?
  end

  def reset_quality
    @quality = 0
  end

  def decrement_expiration
    @expires_in -= 1
  end

  def increment_quality
    @quality += 1
  end

  def negative_expires_in?
    @expires_in.negative?
  end
end
