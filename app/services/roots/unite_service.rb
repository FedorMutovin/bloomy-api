# frozen_string_literal: true

module Roots
  class UniteService < ApplicationService
    DEFAULT_PARAMS = {
      status: Status::UNITED
    }.freeze
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @unite = unite_roots!
        update_source_root_status
      end
      @unite
    end

    private

    def unite_roots!
      Roots::UniteRepository.unite(
        source_id: params[:source][:id],
        source_type: params[:source][:root_type],
        target_id: params[:target][:id],
        target_type: params[:target][:root_type],
        user_id: params[:user_id],
        reason: params[:reason]
      )
    end

    def update_source_root_status
      source_repository.update(params[:source][:id], **DEFAULT_PARAMS)
    end

    def source_repository
      "#{params[:source][:root_type]}Repository".constantize
    end
  end
end
