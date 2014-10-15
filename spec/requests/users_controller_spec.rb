require 'spec_helper'

describe UsersController, :type => :request do
  before(:all){
    Award.new(:name=>'奖品1',:quantity=>5,:flg=>1).save
    Award.new(:name=>'奖品2',:quantity=>3,:flg=>1).save
    Award.new(:name=>'奖品3',:quantity=>1,:flg=>1).save
  }
  it 'can get a prize or nil' do
    Award.count.should == 3
    p '------------------ 现在的奖品为：'
    p Award.all
    post '/prize', {:user=>{:name=>'王长禄',:phone=>'15831287550'},:format => 'json'}
    p '------------------ 现在进行抽奖：'
    User.count.should == 1
    user = User.first
    user.name.should == '王长禄'
    user.phone.should == '15831287550'
    p "------------------ 抽奖用户：#{user.name},#{user.phone}"
    if user.award_id.present?
      p "------------------ 您获得的奖品是：#{user.award_name} -----------------"
      award = Award.find(user.award_id)
      p "------------------ 该奖品现在的数量：#{award.quantity}"
      if award.quantity == 0
        award.flg.should == 0
      else
        award.quantity.should == 4 if award.id == 1
        award.quantity.should == 2 if award.id == 2
      end
    else
      p "------------------ 您没有获奖..."
    end

  end
end
