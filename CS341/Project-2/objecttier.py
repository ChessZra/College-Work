
#
# objecttier.py
# Builds Movie-related objects from data retrieved through 
# the data tier.
#
# Original author: Ellen Kidane and Prof. Joe Hummel
#
import datatier

##################################################################
#
# Movie class:
#
# Constructor(...)
# Properties:
#   Movie_ID: int
#   Title: string
#   Release_Year: string
#
class Movie:
   def __init__(self, movie_id, title, release_year):
      self._movie_id = movie_id
      self._title = title
      self._release_year = release_year
   
   @property
   def Movie_ID(self):
      return self._movie_id
   
   @property
   def Title(self):
      return self._title

   @property
   def Release_Year(self):
      return self._release_year

##################################################################
#
# MovieRating class:
#
# Constructor(...)
# Properties:
#   Movie_ID: int
#   Title: string
#   Release_Year: string
#   Num_Reviews: int
#   Avg_Rating: float
#
class MovieRating(Movie):
   def __init__(self, movie_id, title, release_year, num_reviews, avg_rating):
      super().__init__(movie_id, title, release_year)
      self._num_reviews = num_reviews
      self._avg_rating = avg_rating
   
   @property
   def Num_Reviews(self):
      return self._num_reviews
   
   @property
   def Avg_Rating(self):
      return self._avg_rating

##################################################################
#
# MovieDetails class:
#
# Constructor(...)
# Properties:
#   Movie_ID: int
#   Title: string
#   Release_Date: string
#   Runtime: int (minutes)
#   Original_Language: string
#   Budget: int (USD)
#   Revenue: int (USD)
#   Num_Reviews: int
#   Avg_Rating: float
#   Tagline: string
#   Genres: list
#   Production_Companies: list

class MovieDetails(MovieRating):
   def __init__(self, movie_id, title, release_date, runtime, orig_lang, budget, revenue, num_reviews, avg_rating, tagline, genres, production_companies):
      release_year = release_date.split("-")[0] if release_date else None 
      super().__init__(movie_id, title, release_year, num_reviews, avg_rating)
      self._tagline = tagline
      self._revenue = revenue
      self._release_date = release_date
      self._runtime = runtime
      self._orig_lang = orig_lang 
      self._budget = budget
      self._genres = genres
      self._production_companies = production_companies
   
   @property
   def Tagline(self):
      return self._tagline
   
   @property
   def Revenue(self):
      return self._revenue
   
   @property
   def Release_Date(self):
      return self._release_date

   @property 
   def Runtime(self):
      return self._runtime

   @property
   def Original_Language(self):
      return self._orig_lang

   @property 
   def Budget(self):
      return self._budget
   
   @property 
   def Genres(self):
      return self._genres

   @property 
   def Production_Companies(self):
      return self._production_companies
   
##################################################################
# 
# num_movies:
#
# Returns: the number of movies in the database, or
#          -1 if an error occurs
# 
def num_movies(dbConn):
   try:
      # Get the number of movies in the database
      select_sql = """
         select count(*)
         from Movies
      """
      select_result = datatier.select_n_rows(dbConn, select_sql)
      return select_result[0][0]
   except Exception as e:
      print(f"num_movies failed: {e}")
      return -1
   
##################################################################
# 
# num_reviews:
#
# Returns: the number of reviews in the database, or
#          -1 if an error occurs
#
def num_reviews(dbConn):
   try:
      # Get the number of reviews in the database
      select_sql = """
         select count(*)
         from Ratings
      """
      select_result = datatier.select_n_rows(dbConn, select_sql)
      return select_result[0][0]
   except Exception as e:
      print(f"num_movies failed: {e}")
      return -1

##################################################################
#
# get_movies:
#
# Finds and returns all movies whose name are "like"
# the pattern. Patterns are based on SQL, which allow
# the _ and % wildcards. Pass "%" to get all movies.
#
# Returns: list of movies in ascending order by name, or
#          an empty list, which means that the query did 
#          not retrieve any data
#          (or an internal error occurred, in which case 
#          an error message is already output).
#
def get_movies(dbConn, pattern):
   try:
      # Get the movies matching the pattern
      select_sql = """
         select Movie_ID, Title, strftime("%Y", Release_Date) 
         from Movies
         where Title like ?
         order by Movie_ID
      """
      select_result = datatier.select_n_rows(dbConn, select_sql, parameters=(pattern,))

      # Build a list of Movie objects
      return_list = []
      for movie_id, title, year in select_result:
         return_list.append(Movie(movie_id, title, year))
      return return_list
   except Exception as e:
      print(f"num_movies failed: {e}")
      return -1

##################################################################
#
# get_movie_details:
#
# Finds and returns details about the given movie.
# The movie ID is passed as a parameter (originally from the user)
# and the function returns a MovieDetails object.
# If no movie was found matching that ID, the function returns
# None.
#
# Returns: a MovieDetails object if the search was successful, or
#          None if the search did not find a matching movie
#          (or an internal error occurred, in which case 
#          an error message is already output).
#
def get_movie_details(dbConn, movie_id):
   # This function essentially builds the MovieDetails object
   try:

      # Get the movies and its common attributes (not including genre and company)
      movie_sql = """
         select m.Movie_ID, Title, strftime("%Y-%m-%d", Release_Date), Runtime, 
               Original_Language, Budget, Revenue, count(r.Rating) as Num_Reviews, 
               ifnull(avg(r.Rating), 0) as Avg_Rating, ifnull(Tagline, "")
         from Movies m
         left join Ratings r on m.Movie_ID = r.Movie_ID
         left join Movie_Taglines mt on m.Movie_ID = mt.Movie_ID
         where m.Movie_ID = ?
         group by m.Movie_ID
      """
      select_result = datatier.select_n_rows(dbConn, movie_sql, parameters=(movie_id,))
      if select_result is None:
         return None
      mov, tit, rel, run, orig, bud, rev, num, avg, tag = select_result[0]

      # Let's get the genres separately
      genre_sql = """
         select Genre_Name
         from Movies m
         left join Movie_Genres mg on m.Movie_ID = mg.Movie_ID
         join Genres g on g.Genre_ID = mg.Genre_ID
         where m.Movie_ID = ?
         order by Genre_Name
      """
      select_result = datatier.select_n_rows(dbConn, genre_sql, parameters=(movie_id,))
      genres = [genre[0] for genre in select_result]

      # Let's get the production companies separately
      companies_sql = """
         select Company_Name
         from Movies m
         left join Movie_Production_Companies mg on m.Movie_ID = mg.Movie_ID
         join Companies g on g.Company_ID = mg.Company_ID
         where m.Movie_ID = ?
         order by Company_Name
      """
      select_result = datatier.select_n_rows(dbConn, companies_sql, parameters=(movie_id,))
      companies = [comp[0] for comp in select_result]

      # Create and return the new object
      return MovieDetails(mov, tit, rel, run, orig, bud, rev, num, avg, tag, genres, companies)
   except Exception as e:
      return None

##################################################################
#
# get_top_N_movies:
#
# Finds and returns the top N movies based on their average 
# rating, where each movie has at least the specified number of
# reviews.
# Example: get_top_N_movies(10, 100) will return the top 10 movies
#          with at least 100 reviews.
#
# Returns: a list of 0 or more MovieRating objects
#          note that if the list is empty, it may be because the 
#          minimum number of reviews was too high
#          (or an internal error occurred, in which case 
#          an error message is already output).
#
def get_top_N_movies(dbConn, N, min_num_reviews):
   try:
      # Get the top N movies sorted by average reviews
      movie_sql = """
         select m.Movie_ID, m.Title, strftime("%Y", Release_Date), count(r.Rating) as reviews, 
               avg(r.Rating) as average_rating
         from Movies m
         join Ratings r on m.Movie_ID = r.Movie_ID
         group by r.Movie_ID
         having reviews >= ?
         order by average_rating desc
         limit ?
      """
      select_result = datatier.select_n_rows(dbConn, movie_sql, parameters=(min_num_reviews, N))
      return_list = []
      for mov, tit, rel, num, avg in select_result:
         return_list.append(MovieRating(mov, tit, rel, num, avg))
      return return_list
   except Exception as e:
      print(f"num_movies get_top_N_movies: {e}")
      return []
 
##################################################################
#
# add_review:
#
# Inserts the given review (a rating value between 0 and 10) into
# the database for the given movie.
# It is considered an error if the movie does not exist, and 
# the review is not inserted.
#
# Returns: 1 if the review was successfully added, or
#          0 if not (e.g. if the movie does not exist, or
#                    if an internal error occurred).
#
def add_review(dbConn, movie_id, rating):
   
   try:
      # Check if the movie_id exists in the database
      check_sql = """
         select Movie_ID
         from Movies
         where Movie_ID = ?
      """
      select_result = datatier.select_one_row(dbConn, check_sql, parameters=(movie_id,))
      if not select_result:
         return 0
      
      # Now try inserting the new movie_id: rating row
      insert_sql = """
         insert into Ratings (Movie_ID, Rating) values (?, ?)
      """
      rows_affected = datatier.perform_action(dbConn, insert_sql, (movie_id, rating))
      return 1 if rows_affected == 1 else 0
   except Exception as e:
      print(f"add_review failed: {e}")
      return 0

##################################################################
#
# set_tagline:
#
# Sets the tagline, i.e. summary, for the given movie.
# If the movie already has a tagline, it will be replaced by
# this new value. Passing a tagline of "" effectively 
# deletes the existing tagline.
# It is considered an error if the movie does not exist, and 
# the tagline is not set.
#
# Returns: 1 if the tagline was successfully set, or
#          0 if not (e.g. if the movie does not exist, or
#                    if an internal error occurred).
#
def set_tagline(dbConn, movie_id, tagline):
   try:
      # Check if the movie exists
      check_sql = """
         select Movie_ID 
         from Movies 
         where Movie_ID = ?
      """
      select_result = datatier.select_one_row(dbConn, check_sql, (movie_id,))
      if not select_result:
         return 0
      
      if tagline == "":
         # Delete existing tagline
         delete_sql = """
            delete from Movie_Taglines 
            where Movie_ID = ?
         """
         datatier.perform_action(dbConn, delete_sql, (movie_id,))
         return 1
      else:
         # Insert or replace the tagline
         inrepl_sql = """
            insert or replace into Movie_Taglines (Movie_ID, Tagline)
            values (?, ?)
         """
         rows_affected = datatier.perform_action(dbConn, inrepl_sql, (movie_id, tagline))
         return 1 if rows_affected == 1 else 0
   except Exception as e:
      print(f"set_tagline failed: {e}")
      return 0