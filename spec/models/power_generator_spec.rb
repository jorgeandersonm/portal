require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  it "should have a factory" do
    expect(FactoryBot.build(:power_generator)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:manufacturer) }
    it { should respond_to(:description) }
    it { should respond_to(:price) }
    it { should respond_to(:height) }
    it { should respond_to(:width) }
    it { should respond_to(:lenght) }
    it { should respond_to(:weight) }
    it { should respond_to(:kwp) }
    it { should respond_to(:image_url) }
    it { should respond_to(:structure_type) }
    it { should respond_to(:cubed_weight) }
  end

  context "Enum" do
    it do
      should define_enum_for(:structure_type).with_values([:metalico, :ceramico, :fibrocimento, :laje, :solo, :trapezoidal])
    end
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:manufacturer) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:kwp) }

    it { is_expected.to validate_numericality_of(:height).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(40) }
    it { is_expected.to validate_numericality_of(:width).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
    it { is_expected.to validate_numericality_of(:lenght).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(200) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(3000) }
  end

  context "After create methods" do
    it "#calcule_cubed_weight" do
      power_generator = FactoryBot.build(:power_generator)
      cubed_weight = power_generator.height * power_generator.width * power_generator.lenght * 300
      power_generator.save
      expect(power_generator.cubed_weight).to eq(cubed_weight)
    end
  end
end
