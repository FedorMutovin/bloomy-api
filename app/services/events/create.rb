module Events
  class Create < ApplicationService
    def initialize(params:, user_id:, trigger_params: {})
      @params = params
      @user_id = user_id
      @trigger_params = trigger_params
    end

    private

    attr_reader :params, :user_id, :trigger_params

    def prepare_params
      params[:user_id] = user_id
    end
  end
end
