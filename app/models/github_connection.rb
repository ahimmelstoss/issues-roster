class GithubConnection
  attr_reader :username, :token, :orgs, :data

  def initialize(github_data)
    @username = github_data["username"]
    @token = github_data["token"]
    @data = []
    @orgs = {}
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

  def all_data
    get_issues_for_all_orgs(organizations)
  end

  def get_issues_for_all_orgs(orgs)
    # pass in the orgs hash, for each org, get the name to pass to the request
    # get all the issues for that org
    # push each org and corresponding issues into data array
    # all data should look like [{org_name, issues}, {org_name, issues}]
    orgs.each do |org|
      hash = {:org_name => org['login']}
      request = Typhoeus::Request.new(
        "https://api.github.com/orgs/#{org["login"]}/issues", 
        headers: {Authorization: "token #{token}"}
        )
      response = request.run
      binding.pry
      issues = JSON.parse(response.body).map do |issue|
        issue
      end
      hash[:issues] = issues
      @data << hash
    end
    return @data
  end


end