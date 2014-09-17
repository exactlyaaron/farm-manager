require 'rails_helper'

RSpec.describe Supply, :type => :model do
  it { should belong_to :user }
  
  before do
    Fabricate(:supply, kind: "chemical")
  end

  it { should validate_presence_of :kind }
  it { should validate_presence_of :name }
  it { should validate_presence_of :purchase_date }
  it { should validate_presence_of :vendor }
  it { should validate_presence_of :measure }
  it { should validate_presence_of :price }
end
