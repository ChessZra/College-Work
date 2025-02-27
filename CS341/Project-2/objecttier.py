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
#
class MovieDetails(MovieRating):
   def __init__(self, movie_id, title, release_date, runtime, orig_lang, budget, revenue, num_reviews, avg_rating, tagline):
      release_year = release_date.split("-")[0] if release_date else None 
      super().__init__(movie_id, title, release_year, num_reviews, avg_rating)
      self._tagline = tagline
      self._revenue = revenue
      self._release_date = release_date
      self._runtime = runtime
      self._orig_lang = orig_lang 
      self._budget = budget
   
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
   
##################################################################
# 
# num_movies:
#
# Returns: the number of movies in the database, or
#          -1 if an error occurs
# 
def num_movies(dbConn):
   try:
      sql = """
      select count(*)
      from Movies
      """
      res = datatier.select_n_rows(dbConn, sql)
      return res[0][0]
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
      sql = """
      select count(*)
      from Ratings
      """
      res = datatier.select_n_rows(dbConn, sql)
      return res[0][0]
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
      sql = """
         select Movie_ID, Title, strftime("%Y", Release_Date) 
         from Movies
         where Title like ?
         order by Movie_ID
      """
      res = datatier.select_n_rows(dbConn, sql, parameters=(pattern,))
      return_list = []
      for movie_id, title, year in res:
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
   try:
      sql = """
         select m.Movie_ID, Title, strftime("%Y-%m-%d", Release_Date), Runtime, Original_Language, Budget, Revenue, count(*) as Num_Reviews, avg(r.Rating) as Avg_Rating, Tagline
         from Movies m
         join Ratings r on m.Movie_ID = r.Movie_ID
         join Movie_Taglines mt on m.Movie_ID = mt.Movie_ID
         where m.Movie_ID = ?
         group by m.Movie_ID
      """
      res = datatier.select_n_rows(dbConn, sql, parameters=(movie_id,))
      if res is None or (res and len(res) == 0):
         return None
      details = res[0]
      mov, tit, rel, run, orig, bud, rev, num, avg, tag = details
      return MovieDetails(mov, tit, rel, run, orig, bud, rev, num, avg, tag)
   except Exception as e:
      print(f"num_movies failed: {e}")
      return -1

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
   pass

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
   pass


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
   pass