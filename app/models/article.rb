class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    validates :about, presence: true
    validates :description, presence: true
end
