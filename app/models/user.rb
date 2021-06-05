class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :followers, class_name: 'Relationship',foreign_key: 'follower_id'#,dependent: :destroy# inverse_of: :follower
  has_many :followings, class_name: 'Relationship',foreign_key: 'followed_id'#,dependent: :destroy# inverse_of: :followed
  
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followings, source: :follower
                       
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum:50}
  
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
 
  def follow(user)
    if self != user
      self.followers.create(followed_id: user.id)
    end
  end
 
  def unfollow(user)
    relationship = self.followers.find_by(followed_id: user.id)
    return relationship.destroy if relationship
  end
  
  def following?(user)
    following_users.include?(user)
  end
  
  def self.search(search,word)
      if search == "forward_match"
              @user = User.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
              @user = User.where("name LIKE?","%#{word}")
      elsif search == "perfect_match"
              @user = User.where("#{word}")
      elsif search == "partial_match"
              @user = User.where("name LIKE?","%#{word}%")
      else
              @user = User.all
      end
  end
end
