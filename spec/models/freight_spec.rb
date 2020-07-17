require 'rails_helper'

RSpec.describe Freight, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:freight)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:state) }
    it { should respond_to(:weight_min) }
    it { should respond_to(:weight_max) }
    it { should respond_to(:cost) }
  end
end
