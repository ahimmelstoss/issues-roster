class OrganizationsController < ApplicationController

  def index
    @github = GithubConnection.new(session['github'])
    @organizations = @github.get_organizations
  end

end
