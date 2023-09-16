namespace :set_default_statuses do
  desc "Set default statuses"
  task :set_default_statuses => :environment do
    Item.all.each do |item|
      item.status = 'active'
      item.save!
    end

    Review.all.each do |review|
      review.status = 'approved'
      review.save!
    end
  end
end