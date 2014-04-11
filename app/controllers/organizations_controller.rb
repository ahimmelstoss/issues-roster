class OrganizationsController < ApplicationController

  def index
    @github = GithubConnection.new(session['github'])
    @all_the_stuff = @github.all_data
    binding.pry
  end

end
