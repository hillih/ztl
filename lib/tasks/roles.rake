namespace :roles do
  task reset: :environment do
    ActiveRecord::Base.transaction do
      # Superadmin
      role = Role.find_or_initialize_by(symbol: :sa)
      role.name = 'Super administrator'
      role.permissions = Permission::ALL
      role.save!
      puts "Resetted: #{role.name}"

      # Admin
      role = Role.find_or_initialize_by(symbol: :aa)
      role.name = 'Administrator'
      role.permissions = Permission::ALL.reject { |permission| permission.include?('roles') }
      role.save!
      puts "Resetted: #{role.name}"
    end
  end
end
