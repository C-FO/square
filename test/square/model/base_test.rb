require 'test_helper'

describe Square::Model::Base do
  before do
    @base = Square::Model::Base.new(id: 1, name: 'abc')
  end

  describe '.attr_reader' do
    before do
      Square::Model::Base.attr_reader(:name)
    end

    it 'defines a getter method' do
      @base.name.must_equal 'abc'
    end

    it 'defines an existence checker method' do
      @base.name?.must_equal true
    end
  end

  describe '.from_response' do
    it 'returns an instance of Square::Model::Base' do
      Square::Model::Base.from_response(body: {id: 1}).must_be_instance_of Square::Model::Base
    end
  end

  describe '#initialize' do
    it 'returns an instance of Square::Model::Base' do
      Square::Model::Base.new.must_be_instance_of Square::Model::Base
    end
  end

  describe '#[]' do
    it 'with a symbol argument' do
      @base[:class].must_equal Square::Model::Base
    end

    it 'with a string argument' do
      @base['class'].must_equal Square::Model::Base
    end

    it 'with a missing attribute' do
      @base['ubiregi'].must_be_nil
    end
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      @base.attrs.must_equal({id: 1, name: 'abc'})
    end
  end

  describe '#update' do
    it 'updates an attribute' do
      @base.update(id: 2)
      @base.attrs[:id].must_equal 2
    end
  end

  describe '#empty?' do
    it 'should be false' do
      @base.empty?.must_equal false
    end

    it 'should be true when its empty' do
      base = Square::Model::Base.new(nil)
      base.empty?.must_equal true
    end

    it 'should be true when its empty' do
      base = Square::Model::Base.new({})
      base.empty?.must_equal true
    end
  end
end
