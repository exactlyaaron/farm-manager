require 'rails_helper'

RSpec.describe Field, :type => :model do
  it { should belong_to :user }
  
  before do
    Fabricate(:field)
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :acreage }
  it { should validate_presence_of :crop }
end
