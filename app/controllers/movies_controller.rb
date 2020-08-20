class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # EXACT
      # @movies = Movie.where(title: params[:query])
      # CASE SENSTIVITY
      # @movies = Movie.where('title ILIKE ?', params[:query])
      # CASE SENSITIVITY/TRAILING WORDS
      # @movies = Movie.where('title ILIKE ?', "%#{params[:query]}%")
      # TWO COLUMNS
      # sql_query = "title ILIKE :query OR syllabus ILIKE :query"
      # @movies = Movie.where(sql_query, query: "%#{params[:query]}%")
      # ASSOCIATED TABLES
      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.syllabus @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # ILIKE
      # app --> apple
      # query --> queries X

      # @@
      # jump --> jumps, jumped
      # query --> queries
      # app --> apple X

      # PG SEARCH
      # @movies = Movie.search_by_title_and_syllabus(params[:query])

      # ELASTIC SEARCH
      @movies = Movie.search(params[:query])
    else
      @movies = Movie.all
    end
  end
end


# MULTI FIELD SEARCH/FILTERING
    # @movies = Movie.all
    # @movies = Movie.where('title ILIKE ?', "%#{params[:query]}%") if params[:query].present?
    # @movies = Movie.where('syllabus ILIKE ?', "%#{params[:syllabus_text]}%") if params[:syllabus_text].present?
