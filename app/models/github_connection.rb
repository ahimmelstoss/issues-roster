class GithubConnection
  attr_reader :typhoeus_request, :orgs, :repos, :issues, :username, :token

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
    @typhoeus_request = TyphoeusRequest.new(username, token)
  end

  def get_organizations
    orgs = JSON.parse(typhoeus_request.make_request("https://api.github.com/user/orgs",
      headers: {Authorization: "token #{token}"}).body).map do |org| 
      org["login"]
    end
  end

  def get_repos(organization)
    repos = JSON.parse(typhoeus_request.make_request("https://api.github.com/orgs/#{organization}/repos",
      headers: {Authorization: "token #{token}"}).body).map do |repo|
      repo["name"]
    end
  end

  def get_issues(organization, repo)
    issues = JSON.parse(typhoeus_request.make_request("https://api.github.com/repos/#{organization}/#{repo}/issues",
      headers: {Authorization: "token #{token}"}).body).map do |issue|
      issue
    end
  end

  TyphoeusRequest = Struct.new(:username, :token) do 
    def make_request(url, header)
      request = Typhoeus::Request.new(url, header)
      response = request.run
    end
  end


end