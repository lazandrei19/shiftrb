class SearchesController < ApplicationController
  def search

    projectSearch = Sunspot.search(Project) do
      keywords params[:q] do
        boost_fields :name => 10.0
        boost_fields :headline => 5.0
      end
      paginate :page => 1, :per_page => 5
    end

    userSearch = Sunspot.search(User) do
      keywords params[:q]
      paginate :page => 1, :per_page => 5
    end

    @projects = projectSearch.results
    @users = userSearch.results
  end
end