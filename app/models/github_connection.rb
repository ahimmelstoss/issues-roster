class GithubConnection
  attr_reader :username, :token, :orgs, :repos, :issues

  #TODO: refactor repeated code

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
  end

  def get_organizations
    request = Typhoeus::Request.new(
      "https://api.github.com/user/orgs",
      headers: {Authorization: "token #{token}"}
    )
    response = request.run
    orgs = JSON.parse(response.body).map do |org| 
      org["login"]
    end
  end

  def get_repos(organization)
    request = Typhoeus::Request.new(
      "https://api.github.com/orgs/#{organization}/repos",
      headers: {Authorization: "token #{token}"}
      )
    response = request.run
    repos = JSON.parse(response.body).map do |repo|
      repo["name"]
    end
  end

  def get_issues(organization, repo)
    request = Typhoeus::Request.new(
      "https://api.github.com/repos/#{organization}/#{repo}/issues",
      headers: {Authorization: "token #{token}"}
      )
    response = request.run
    repos = JSON.parse(response.body).map do |issue|
      issue
    end
  end

end