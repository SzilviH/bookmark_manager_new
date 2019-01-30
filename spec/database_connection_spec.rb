require 'database_connection'

describe DatabaseConnection do

  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')
      DatabaseConnection.setup('bookmark_manager_test')
    end
  end

  describe '.query' do
    it 'use the class instance variable from setup to execute the sql query' do
      connection = DatabaseConnection.setup('bookmark_manager_test')
      expect(connection).to receive(:exec).with('sql')
      DatabaseConnection.query('sql')
    end
  end
end
