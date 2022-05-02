module RepoSearch

  def search(query_param)
	fetch_repo_details(get_result_request(query_param))
  end

  private

  def get_result_request(query_param)
  	uri = URI("https://api.github.com/search/repositories")
	param = {"q": query_param}
	uri.query = URI.encode_www_form(param)
	res = Net::HTTP.get_response(uri)
	res = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
	res["items"]
  end

  def fetch_repo_details(items)
  	items.map {|repo| {"name": repo["name"], "full_name": repo["full_name"], "url": repo["url"]}}
  end
end	