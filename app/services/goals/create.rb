# frozen_string_literal: true

module Goals
  class Create
    def initialize(params, user_id:)
      @params = params
      @user_id = user_id
    end

    def call
      prepare_params
      create_goal!
    end

    private

    attr_reader :params, :user_id

    def create_goal!
      GoalRepository.add(params:)
    end

    def prepare_params
      params[:user_id] = user_id
      params[:tasks_attributes]&.each { |task| task.merge!(user_id:) }
    end
  end
end
