class OrganizationsController < ApplicationController

  def index
    @github = GithubConnection.new(session['github'])
    @username = @github.username
    @organizations = @github.get_organizations
  end

  def show
    @github = GithubConnection.new(session['github'])
    @organization = params[:organization]
    @repos = @github.get_repos(@organization)
  end

end
