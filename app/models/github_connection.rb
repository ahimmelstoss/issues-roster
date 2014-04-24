class GithubConnection
  attr_reader :orgs, :repos, :issues, :username, :token

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
  end

  def get_organizations
    orgs = json_parse("https://api.github.com/user/orgs", "login")
  end

  def get_repos(organization)
    repos = json_parse("https://api.github.com/orgs/#{organization}/repos", "name")
  end

  def get_issues(organization, repo)
    issues = json_parse("https://api.github.com/repos/#{organization}/#{repo}/issues")
  end

  def make_request(url, header)
    request = Typhoeus::Request.new(url, header)
    response = request.run
  end

  def json_parse(url, key = nil)
    JSON.parse(make_request(url, headers: {Authorization: "token #{token}"}).body).map do |to_parse| 
      key ? to_parse[key] : to_parse
    end
  end

end