class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
        t.belongs_to :user, index: true
    	t.string :slug , :null => false #域名
    	t.string :title #标题
    	t.string :poster #封面
    	t.string :source #source
        t.text :body #简单介绍
        t.string :github #地址
    	t.string :git #仓库地址
    	
        #version
        t.integer :version, :default => 0
    	#count
    	t.integer :likes_count, :default => 0 
    	t.integer :subscriptions_count, :default => 0 
    	#
    	t.integer :pages_count, :default => 0 
    	t.integer :views_count, :default => 0 
    	t.integer :users_count, :default => 0 
    	t.integer :forks_count, :default => 0 
    	t.integer :stars_count, :default => 0 
    	t.integer :comments_count, :default => 0 
    	#状态
        t.boolean :trashed, default: false
    	t.integer :status, :default => 0 #创建-0，进行中-1，审核-2，完成-3

      t.timestamps
    end

    #add index
    add_index  :wikis,:slug

  end
end
