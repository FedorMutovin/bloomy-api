# frozen_string_literal: true

module Goals
  class Create < Events::Create

    def call
      prepare_params
      ActiveRecord::Base.transaction do
        @goal = create_goal!
        link_event_relationship unless @trigger_params.empty?
      end

      @goal
    end

    private

    def create_goal!
      GoalRepository.add(params:)
    end

    def link_event_relationship
      Events::Relationships::Create.new(
        trigger_id: trigger_params['id'],
        trigger_type: trigger_params['event_type'],
        target_id: @goal.id,
        target_type: @goal.class.name
      ).call
    end

    def prepare_params
      super
      params[:tasks_attributes]&.each { |task| task.merge!(user_id:) }
    end
  end
end
