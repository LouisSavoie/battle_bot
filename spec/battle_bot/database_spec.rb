# frozen_string_literal: true

require 'battle_bot/database'
require 'yaml'

RSpec.describe BattleBot::Database do
  let(:database) { described_class.new }

  testdata = { server1: { battle1: { player1: 'Tom', player2: 'Jake' },
                          battle2: { player1: 'Carol', player2: 'Jackie' } },
               server2: { battle1: { player1: 'DQ', player2: 'Dave' },
                          battle2: { player1: 'Joe', player2: 'Tyler' } } }

  it 'has a data hash' do
    expect(database.data.class).to eq(Hash)
  end

  describe '.new_file' do
    it 'creates a blank yaml file' do
      database.new_file('test.yml')
      expect(YAML.safe_load(File.read('test.yml'))).to eq(database.data)
      File.delete('test.yml')
    end
  end

  describe '.read_file' do
    it 'reads YAML file into @data' do
      File.open('readtest.yml', 'w') { |file| file.write(testdata.to_yaml) }
      database.read_file('readtest.yml')
      expect(database.data).to eq(testdata)
      File.delete('readtest.yml')
    end
  end
end
