class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    #delete duplicate users
    dupeEmails = User.select("email, count(email) as quantity").group(:email).having("quantity > 1")
    dupeEmails.each do |user|
      dupes = User.where(:email=>user.email)
      dupes = dupes.unshift
      dupes.each do |dupeUser|
        dupeUser.delete
      end
    end
    
  add_index :users, :email, unique: true
  end
end
