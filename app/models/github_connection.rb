class GithubConnection
  attr_reader :username, :token, :orgs, :orgs_repos, :issues

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
    @orgs_repos = []
  end

  def organizations
    get_organizations
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

  def all_orgs_repos
    #[{:org_name => "org1", :org_repos => [repo1, repo2]}, {:org_name => "org2", :org_repos => [repo1, repo2]}]
    get_repos_for_all_orgs(organizations)
  end

  def get_repos_for_all_orgs(orgs)
    orgs.each do |org|
      hash = {:org_name => org["login"]}
      request = Typhoeus::Request.new(
        "https://api.github.com/orgs/#{org["login"]}/repos",
        headers: {Authorization: "token #{token}"}
        )
      response = request.run
      repos = JSON.parse(response.body).map do |repo|
        repo["name"]
      end
      hash[:org_repos] = repos
      @orgs_repos << hash
    end
    @orgs_repos
  end

  #GET /repos/:owner/:repo/issues
  def get_issues_for_all_repos
  end
  

end