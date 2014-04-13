class GithubConnection
  attr_reader :username, :token, :orgs, :repos, :issues

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

  #gets all the repos for one org, given an org (method called in controller for show; params gives org name to then be passed into the method)
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

  #GET /repos/:owner/:repo/issues
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

  #old
  #[{:org_name => "org1", :org_repos => [repo1, repo2]}, {:org_name => "org2", :org_repos => [repo1, repo2]}]

end