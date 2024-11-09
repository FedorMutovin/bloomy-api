module Tasks
  class Create < Events::Create

    def call
      prepare_params
      ActiveRecord::Base.transaction do
        @task = create_task!
        link_event_relationship unless @trigger_params.empty?
      end

      @task
    end

    private

    def create_task!
      TaskRepository.add(params:)
    end

    def link_event_relationship
      Events::Relationships::Create.new(
        trigger_id: @trigger_params['id'],
        trigger_type: @trigger_params['event_type'],
        target_id: @task.id,
        target_type: @task.class.name
      ).call
    end
  end
end
