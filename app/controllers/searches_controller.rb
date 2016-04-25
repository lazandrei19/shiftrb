class SearchesController < ApplicationController
  def search
    # search = Project.search do
    #   fulltext :q do
    #     boost_fields :name => 10.0
    #     boost_fields :headline => 5.0
    #   end
    # end

    search = Sunspot.search(Project) do
      keywords params[:q] do
        boost_fields :name => 10.0
        boost_fields :headline => 5.0
      end
    end

    @projects = search.results
  end
end