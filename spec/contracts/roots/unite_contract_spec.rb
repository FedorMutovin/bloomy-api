# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::UniteContract do
  subject(:contract) { described_class.new }

  let(:target_id) { 'id 1' }
  let(:source_id) { 'id 2' }
  let(:target_type) { 'Goal' }
  let(:source_type) { 'Goal' }

  let(:params) do
    {
      reason: 'Event Name',
      target: {
        id: target_id,
        event_type: target_type,
      },
      source: {
        id: source_id,
        event_type: source_type,
      }
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(params)
      expect(result).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if reason is missing' do
      result = contract.call(params.except(:reason))
      expect(result.errors[:reason]).to include('is missing')
    end
  end

  context 'when rule(:source, :target)' do
    context "when source and target have not the same root type" do
      let(:target_type) { 'Task' }
      it 'fails' do
        result = contract.call(params)
        expect(result.errors.filter(:base?).map(&:to_s))
          .to include(I18n.t('errors.roots.unite.rule_type_can_not_be_different'))
      end
    end

    context "when source and target have the same root" do
      let(:target_id) { source_id }
      it 'fails' do
        result = contract.call(params)
        expect(result.errors.filter(:base?).map(&:to_s))
          .to include(I18n.t('errors.roots.unite.root_can_not_be_same'))
      end
    end
  end
end
