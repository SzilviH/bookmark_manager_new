require 'pg'

def setup_test_database
  p "Setting up test database..."
  connection = PG.connect(dbname: 'bookmark_manager_test')
  # Clear the bookmarks table
  connection.exec("TRUNCATE bookmarks;")
end

def persisted_data(id:)
  conn = PG.connect(dbname: 'bookmark_manager_test')
  conn.query("SELECT * FROM bookmarks WHERE id = '#{id}';")
end
