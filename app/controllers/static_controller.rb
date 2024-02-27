class StaticController < ApplicationController
  def dashboard
    # TODO: Add cookies to get user's most-interacted-with friends
    @friends = current_user.friends.first(5)
  end
end
