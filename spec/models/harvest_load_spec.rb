require 'rails_helper'

RSpec.describe HarvestLoad, :type => :model do
  it { should belong_to :field }

  it { should validate_presence_of :date }
  it { should validate_presence_of :receipt_number }
  it { should validate_presence_of :price_per_bushel }
  it { should validate_presence_of :bushels_sold }
end