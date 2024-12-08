# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Travels::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { TravelRepository }
    let(:record_factory) { :travel }
    let(:attributes) do
      {
        user_id: user.id,
        destination: 'travel destination',
        description: 'travel description',
        initiated_at: DateTime.current,
        start_at: DateTime.current - 1.hour,
        end_at: DateTime.current + 10.hours
      }
    end
    let(:root_schedule) { build_stubbed(:root_schedule) }
    let(:before_each) do
      lambda {
        allow(Roots::ScheduleRepository).to receive(:add).and_return(root_schedule)
      }
    end

    context 'when adding a schedule for departure and return' do
      it 'adds departure and return schedules' do
        allow(repository_class).to receive(:add).and_return(record)
        allow(Roots::ScheduleRepository).to receive(:add)

        service_call

        expect(Roots::ScheduleRepository).to have_received(:add).with(
          scheduable_id: record.id,
          scheduable_type: record.class.name,
          scheduled_at: record.start_at,
          user_id: user.id,
          details: { destination: record.destination }
        )

        expect(Roots::ScheduleRepository).to have_received(:add).with(
          scheduable_id: record.id,
          scheduable_type: record.class.name,
          scheduled_at: record.end_at,
          user_id: user.id,
          details: { destination: 'Home' }
        )
      end
    end
  end
end
