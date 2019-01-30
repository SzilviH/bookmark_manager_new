require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it "Returns a list of bookmarks from database" do
      bookmark = Bookmark.create(url: "www.google.com", title: "Google")
      Bookmark.create(url: "www.yahoo.com", title: "Yahoo")
      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq 2
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'www.google.com'
    end
  end

  describe '.create' do
    it 'should create a new bookmark and add it to the database' do
      bookmark = Bookmark.create(url: 'www.test.com', title: 'test')
      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'test'
      expect(bookmark.url).to eq 'www.test.com'
    end
  end

  describe '.delete' do
    it 'should delete a bookmark' do
      bookmark = Bookmark.create(url: 'www.test.com', title: 'test')
      Bookmark.delete(bookmark.title)
      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq 0
    end
  end

  describe '.update' do
    it 'should update an existing bookmark' do
      bookmark = Bookmark.create(url: 'www.test.com', title: 'test')
      persisted_data = persisted_data(id: bookmark.id)
      Bookmark.update('test', 'test_update', 'www.test.com/update')
      expect(Bookmark.all[0].id).to eq persisted_data.first['id']
      expect(Bookmark.all[0].title).to eq 'test_update'
      expect(Bookmark.all[0].url).to eq 'www.test.com/update'
    end
  end
end
