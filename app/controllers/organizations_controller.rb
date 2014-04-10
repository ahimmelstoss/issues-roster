class OrganizationsController < ApplicationController

  def index
    @github = GithubConnection.new(session['github'])
    @organizations = @github.organizations
  end

end
