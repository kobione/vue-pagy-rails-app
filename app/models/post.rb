class Post < ApplicationRecord
    scope :cleaner, -> { select(:id, :title, :body, :published) }
end
