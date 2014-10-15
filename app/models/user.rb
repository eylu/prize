class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :phone
  validates_uniqueness_of :phone
  PEOPLES = 10

  after_create :update_award

  def get_prize
    lottery(prizes, PEOPLES)
  end

  def prizes
    @awards = Award.where(flg:1).all.collect{|item| {id: item.id, quantity: item.quantity, name: item.name} }
  end

  #
  # lottery 中奖算法
  # @param items [Array] 奖项，格式为[{},{}]
  # @param total=100 [Integer] 预计参加数，依此数算中奖几率
  #
  # @return [Integer] 返回本活动的n等奖
  def lottery(items,total=100)
    return false unless items.is_a?(Array) && items[0].is_a?(Hash)
    pool = {}
    items.each do |prize|
      prize[:quantity].times do |i|
        while true
          key = rand(total)
          if !pool[key]
            pool[key] = prize
            break
          end
        end
      end
    end
    pool[rand(total)]
  end

  def is_winner?
    !self.award_id.nil?
  end

  def update_award
    if self.award_id
      award = Award.find(self.award_id)
      Award.decrement_counter(:quantity, self.award_id) if award.quantity > 1
      award.update_attributes({flg: 0, quantity: 0}) if award.quantity == 1
    end
  end
end
