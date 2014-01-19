require 'spec_helper'

describe AuthKey do

  it 'should create a auth token a target user' do
    @user = User.create name: 'Mary', email: 'mary@qq.com', password: 'passworD1'
    token = AuthKey.create_key_for @user
    token.should_not be nil
  end
end
