require 'spec_helper'

describe User do
  before(:all){
    Award.new(:name=>'奖品1',:quantity=>5,:flg=>1).save
    Award.new(:name=>'奖品2',:quantity=>3,:flg=>1).save
  }
  let(:user){
    User.new(:name=>'王长禄',:phone=>'15831287550')
  }

  it 'can query a list of award' do
    Award.all.length.should == 2
  end

  it 'can get a prize' do
    prize = user.get_prize
    p prize
    if prize.present?
      prize.should have_key(:name)
    else
      prize.should be_nil
    end
  end

  it 'can return a winner or no!' do
    expect(user.is_winner?).to eq(false)
  end
end
