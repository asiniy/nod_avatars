namespace :db do
  desc 'Populate database with 100 random records'
  task populate: :environment do
    rand(100..1000).times do
      Fabricate(:photo)
    end
  end
end
