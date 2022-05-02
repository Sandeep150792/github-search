class SearchController < ApplicationController
  include RepoSearch

  def search_repo
  	if params[:search].blank?
  	  redirect_to action: 'index', flash: {error: "Please enter repo name"}
	  else
	    @repo_names = search(params[:search])
    end
  end
end

