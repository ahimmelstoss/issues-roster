class OrganizationsController < ApplicationController
  before_action :github_connection, only: [:index, :show]

  def index
    @username = @github.username
    @organizations = @github.get_organizations
  end

  def show
    @organization = params[:organization]
    @repos = @github.get_repos(@organization)
  end

  private
  def github_connection
    @github = GithubConnection.new(session['github'])
  end

end