class Article < ApplicationRecord
    has_many :article_tags, dependent: :destroy
    has_many :tags , through: :article_tags
    validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
    validates :about, :description, presence: true
end
