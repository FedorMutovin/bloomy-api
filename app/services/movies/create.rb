# frozen_string_literal: true

module Movies
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @movie = create_movie!
        add_event_relationship if params[:trigger].present?
      end

      @movie
    end

    private

    def create_movie!
      MovieRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        status: params[:status],
        rating: params[:rating],
        completed_at: params[:completed_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @movie.id,
        impactable_type: @movie.class.name
      )
    end
  end
end
