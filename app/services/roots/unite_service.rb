# frozen_string_literal: true

module Roots
  class UniteService < ApplicationService
    param :params, reader: :private

    def call
      unite_roots!
    end

    private

    def unite_roots!
      Roots::UniteRepository.unite(
        source_id: params[:source][:id],
        source_type: params[:source][:event_type],
        target_id: params[:target][:id],
        target_type: params[:target][:event_type],
        user_id: params[:user_id],
        reason: params[:reason]
      )
    end
  end
end
