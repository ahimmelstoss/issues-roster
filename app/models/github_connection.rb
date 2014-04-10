class GithubConnection
  attr_reader :username, :token, :orgs, :issues, :repos

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
    @orgs = {}
    @issues = {}
    @repos = {}
  end

  def organizations
    @organizations ||= get_organizations
  end

  def get_organizations
    request = Typhoeus::Request.new(
      "https://api.github.com/user/orgs",
      headers: {Authorization: "token #{token}"}
    )
    response = request.run
    orgs = JSON.parse(response.body).map {|org| org["login"]}
  end

end