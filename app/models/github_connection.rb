class GithubConnection
  attr_reader :username, :token, :orgs, :issues, :repos

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
    @orgs = {}
    @repos = {}
  end

  def get_organizations
    request = Typhoeus::Request.new(
      "https://api.github.com/user/orgs",
      headers: {Authorization: "token #{token}"}
    )
    response = request.run
    orgs = JSON.parse(response.body).map do |org| 
      org
    end
  end

  def get_repos(organization)
    request = Typheous::Request.new(
      "https://api.github.com/orgs/#{organization}/repos", 
      headers: {Authorization: "token #{token}"}
      )
    response = request.run
    repos = JSON.parse(reponse.body).map do |repo|
      repo
    end
  end

end