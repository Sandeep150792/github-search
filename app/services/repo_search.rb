module RepoSearch

  def search(query_param)
    get_result_request(query_param)
  end

  private

  def get_result_request(query_param)
    begin
      uri = URI("https://api.github.com/search/repositories")
      param = {"q": query_param}
      uri.query = URI.encode_www_form(param)
      res = Net::HTTP.get_response(uri)
      res = JSON.parse(res.body)
      fetch_repo_details(res["items"])
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, SocketError => e
       puts "Error in receiving the response"
    end
  end

  def fetch_repo_details(items)
    items.map {|repo| {"name": repo["name"], "full_name": repo["full_name"], "url": repo["url"]}}
  end
end	