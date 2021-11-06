# frozen_string_literal: true

require 'battle_bot/database'
require 'yaml'

RSpec.describe BattleBot::Database do
  subject(:database) { described_class.new }

  let(:testdata) do
    { server1: { battle1: { player1: 'Tom', player2: 'Jake' },
                 battle2: { player1: 'Carol', player2: 'Jackie' } },
      server2: { battle1: { player1: 'DQ', player2: 'Dave' },
                 battle2: { player1: 'Joe', player2: 'Tyler' } } }
  end

  it 'has a data hash' do
    expect(database.data.class).to eq(Hash)
  end

  describe '.write_file' do
    it 'writes @data to YAML file' do
      database.write_file('test.yaml')
      expect(YAML.safe_load(File.read('test.yaml'))).to eq(database.data)
      File.delete('test.yaml')
    end
  end

  describe '.read_file' do
    it 'reads YAML file into @data' do
      File.open('readtest.yaml', 'w') { |file| file.write(testdata.to_yaml) }
      database.read_file('readtest.yaml')
      expect(database.data).to eq(testdata)
      File.delete('readtest.yaml')
    end
  end
end
