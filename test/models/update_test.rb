require 'test_helper'

describe Update do
  before do
    @attr = { name: 'xyz', installed: 'x.x.x', current: 'y.y.y' }
  end

  it 'allows name, installed, current' do
    Update.new(@attr).valid?.must_equal true
  end

  it 'must have a name' do
    @attr.delete(:name)
    Update.new(@attr).valid?.must_equal false
  end

  it 'must have installed version' do
    @attr.delete(:installed)
    Update.new(@attr).valid?.must_equal false
  end

  it 'must have current version' do
    @attr.delete(:current)
    Update.new(@attr).valid?.must_equal false
  end
end
