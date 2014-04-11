class OrganizationsController < ApplicationController

  def index
    @github = GithubConnection.new(session['github'])
    @orgs_repos = @github.all_orgs_repos
  end

end
