# frozen_string_literal: true

module Movies
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:status).filled(:string, included_in?: Movie::ALLOWED_STATUSES)
      optional(:rating).filled(:string, included_in?: Movie::ALLOWED_RATINGS)
      optional(:trigger).hash(Triggers::CreateContract.schema)
    end
  end
end
