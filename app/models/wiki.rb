class Wiki < ActiveRecord::Base
  include Likeable
  include Trashable
  include Subscribable
  belongs_to :user
  has_many :comments, as: 'commentable'
  
  validates :title, :body, :github, :git, presence: true
  validates :slug, presence: true, format: { with: /\A[a-zA-Z0-9-]+\z/ }, uniqueness: { case_sensitive: false }

end
