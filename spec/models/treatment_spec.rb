require 'rails_helper'

RSpec.describe Treatment, :type => :model do
  it { should belong_to :field }
  it { should belong_to :supply }

  it { should validate_presence_of :date }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :field_id }
  it { should validate_presence_of :supply_id }
end