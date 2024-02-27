# frozen_string_literal: true

class ApplicationInteractor
  include Interactor

  private

  def handle_error(error, status = 400)
    return if context.failure?

    context.fail!(error: error, status: status)
  end
end