class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: {maximum: 50 }
    validates :email, presence: true, length: {maximum: 225 },
                     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                     uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_many :connections
    has_many :likes, through: :connections, source: :micropost
    # has_many :reverses_of_connection, class_name: 'Connection', foreign_key: 'micropost_id'
    # has_many :microposters, through: :reverses_of_connection, source: :user
    
    
    
    def follow(other_user)
        unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end 
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
 
    end 
    
    def following?(other_user)
        self.followings.include?(other_user)
    end 
    
    def feed_microposts
        Micropost.where(user_id: self.following_ids + [self.id])
    end
    
    def like(other_micropost)
        unless self == other_micropost
        self.connections.find_or_create_by(micropost_id: other_micropost.id)
        end 
    end 
    
    def unlike(other_micropost)
        connection = self.connections.find_by(micropost_id: other_micropost.id)
        connection.destroy if connection
    end 
    
    def liking?(other_micropost)
        self.likes.include?(other_micropost)
    end 
    
        
        
end
