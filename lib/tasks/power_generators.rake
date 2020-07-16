namespace :power_generators do
  desc "Update cubed weight from all Power Generator"
  task set_cubed_weight: :environment do
    PowerGenerator.all.each do |power_generator|
      cubed_weight = power_generator.height * power_generator.width * power_generator.lenght * 300
      power_generator.update(cubed_weight: cubed_weight)
    end
  end
end
