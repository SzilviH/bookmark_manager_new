require 'pg'
require_relative 'database_connection'

class Bookmark

  attr_reader :bookmarks

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(url:, title:)
    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url)
      VALUES('#{title}', '#{url}')
      RETURNING id, url, title")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(title)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE title='#{title}'")
  end

  def self.update(old_title, updated_title, updated_url)
    DatabaseConnection.query("UPDATE bookmarks SET title = '#{updated_title}', url = '#{updated_url}' WHERE title = '#{old_title}'")
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

end
