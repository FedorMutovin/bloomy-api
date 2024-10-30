# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # TODO: before_action :set_paper_trail_whodunnit after current user implementation
  # TODO: add protect from forgery with sessions
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
