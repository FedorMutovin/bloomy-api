# frozen_string_literal: true

class EverydayQuoteRepository
  def self.by_user_id(user_id:)
    EverydayQuote.where(user_id:).to_a
  end
end
