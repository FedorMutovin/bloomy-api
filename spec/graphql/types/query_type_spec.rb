# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'user' do
    subject(:result) do
      BloomyApiSchema.execute(query, variables:).as_json
    end

    let(:user) { create(:user) }
    let!(:goals) { create_pair(:goal, user:) }

    let(:query) do
      <<~GRAPHQL
        query($id: ID!) {
          user(id: $id) {
            id
            email
            goals {
              id
              name
              createdAt
            }
          }
        }
      GRAPHQL
    end

    let(:variables) { { 'id' => user.id } }

    it 'returns user with associations' do
      expected_goals = goals.map do |goal|
        {
          'id' => goal.id.to_s,
          'name' => goal.name,
          'createdAt' => goal.created_at.iso8601
        }
      end

      expected_user_data = {
        'id' => user.id.to_s,
        'email' => user.email,
        'goals' => expected_goals
      }

      # Агрегируем ожидания
      aggregate_failures do
        expect(result['errors']).to be_nil
        expect(result.dig('data', 'user', 'id')).to eq(expected_user_data['id'])
        expect(result.dig('data', 'user', 'email')).to eq(expected_user_data['email'])
        expect(result.dig('data', 'user', 'goals')).to eq(expected_user_data['goals'])
      end
    end
  end

  describe 'goals' do
    subject(:result) do
      BloomyApiSchema.execute(query, variables:).as_json
    end

    let(:user) { create(:user) }
    let!(:goals) { create_pair(:goal, user:) }
    let!(:other_user) { create(:user) }
    let!(:other_goals) { create_pair(:goal, user: other_user) }

    let(:query) do
      <<~GRAPHQL
        query($userId: ID!) {
          goals(userId: $userId) {
            id
            name
            createdAt
          }
        }
      GRAPHQL
    end

    let(:variables) { { 'userId' => user.id } }

    it 'returns goals for the specific user' do
      # Агрегируем ожидания
      aggregate_failures do
        expect(result['errors']).to be_nil

        expected_goals = goals.map do |goal|
          {
            'id' => goal.id.to_s,
            'name' => goal.name,
            'createdAt' => goal.created_at.iso8601
          }
        end

        expect(result.dig('data', 'goals')).to eq(expected_goals)
      end
    end

    it 'does not return goals for another user' do
      other_variables = { 'userId' => other_user.id }

      other_result = BloomyApiSchema.execute(query, variables: other_variables).as_json

      expected_other_goals = other_goals.map do |goal|
        {
          'id' => goal.id.to_s,
          'name' => goal.name,
          'createdAt' => goal.created_at.iso8601
        }
      end

      aggregate_failures do
        expect(other_result['errors']).to be_nil
        expect(other_result.dig('data', 'goals')).to eq(expected_other_goals)
      end
    end
  end
end
