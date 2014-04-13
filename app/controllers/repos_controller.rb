class ReposController < ApplicationController
  before_action :github_connection, only: [:show]

  #TODO have this show page rendered via ajax upon clicking on individual repo (like a toggle feature?)
  def show
    @repo = params[:repo]
    @organization = params[:organization]
    @issues = @github.get_issues(@organization, @repo)
  end

  private
  def github_connection
    @github = GithubConnection.new(session['github'])
  end

end
