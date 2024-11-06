# frozen_string_literal: true

module Goals
  class Create
    def initialize(params, user_id:)
      @params = params.except(:triggers_attributes)
      @triggers_params = params[:triggers_attributes]
      @user_id = user_id
    end

    def call
      prepare_params
      ActiveRecord::Base.transaction do
        @goal = create_goal!
        link_event_relationship if @triggers_params
      end

      @goal
    end

    private

    attr_reader :params, :user_id

    def create_goal!
      GoalRepository.add(params:)
    end

    def link_event_relationship
      trigger_data = @triggers_params.first
      Events::RelationshipRepository.add(
        trigger_id: trigger_data['id'],
        trigger_type: trigger_data['event_type'],
        target_id: @goal.id,
        target_type: @goal.class.name
      )
    end

    def prepare_params
      params[:user_id] = user_id
      params[:tasks_attributes]&.each { |task| task.merge!(user_id:) }
    end
  end
end
