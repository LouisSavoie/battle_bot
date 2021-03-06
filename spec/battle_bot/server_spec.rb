# frozen_string_literal: true

require 'battle_bot/server'
require 'battle_bot/battle'
require 'battle_bot/player'

RSpec.describe BattleBot::Server do
  let(:player) { BattleBot::Player.new(1, 'Bob', 10, 1, 1) }
  let(:battle) { BattleBot::Battle.new(player, player) }
  let(:server) { described_class.new('test') }

  it 'has a battles hash' do
    expect(server.battles.class).to eq(Hash)
  end

  it 'has a players hash' do
    expect(server.players.class).to eq(Hash)
  end

  it 'has an id' do
    expect(server.server_id).to eq('test')
  end

  describe '.add_battle' do
    it 'can add battles' do
      server.add_battle(battle)
      expect(server.battles['1_1']).to eq(battle)
    end
  end

  describe '.remove_battle' do
    before do
      server.add_battle(battle)
    end

    it 'can delete battles' do
      server.remove_battle('1_1')
      expect(server.battles['1_1']).to eq(nil)
    end
  end

  describe '.add_player' do
    it 'can add players' do
      server.add_player(player)
      expect(server.players[1]).to eq(player)
    end
  end

  describe '.remove_player' do
    it 'can remove players' do
      server.add_player(player)
      server.remove_player(1)
      expect(server.players[1]).to eq(nil)
    end
  end
end
