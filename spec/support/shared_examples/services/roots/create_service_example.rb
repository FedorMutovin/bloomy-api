# frozen_string_literal: true

RSpec.shared_examples 'Roots::CreateService' do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:params) { attributes }

  describe '#call' do
    context 'when creating a new root' do
      it 'creates a new root with the specified attributes' do
        allow(repository_class).to receive(:add)
        service_call
        expect(repository_class).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an roots relationship' do
      let(:origin_root_params) do
        { origin_root: { id: 'id', root_type: 'Goal' } }
      end

      let(:params) { attributes.merge(origin_root_params) }
      let(:record) { build_stubbed(record_factory, attributes.merge(user:)) }

      it 'adds an roots relationship if origin root params is present' do
        allow(repository_class).to receive(:add).and_return(record)
        allow(Roots::Relationships::CreateService).to receive(:call)

        service_call

        expect(Roots::Relationships::CreateService).to have_received(:call).with(
          triggerable_id: origin_root_params[:origin_root][:id],
          triggerable_type: origin_root_params[:origin_root][:root_type],
          impactable_id: record.id,
          impactable_type: record.class.name,
          user_id: user.id
        )
      end
    end
  end
end
