class SearchController < ApplicationController
  
  def search_repo
  	if params[:search].blank?
  	  redirect_to action: 'index', flash: {error: "Please enter repo name"}
	else
	  uri = URI("https://api.github.com/search/repositories")
	  param = {"q": params["search"]}
	  uri.query = URI.encode_www_form(param)
	  res = Net::HTTP.get_response(uri)
	  res = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
	  @repo_names = fetch_repo_details(res["items"])
    end
  end


  private

  	def fetch_repo_details(items)
  	  items.map {|repo| {"name": repo["name"], "full_name": repo["full_name"], "url": repo["url"]}}
  	end
end

