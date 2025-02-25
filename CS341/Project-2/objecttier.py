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
   pass

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
class MovieRating:
   pass

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
class MovieDetails:
   pass

##################################################################
# 
# num_movies:
#
# Returns: the number of movies in the database, or
#          -1 if an error occurs
# 
def num_movies(dbConn):
   pass

##################################################################
# 
# num_reviews:
#
# Returns: the number of reviews in the database, or
#          -1 if an error occurs
#
def num_reviews(dbConn):
   pass

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
   pass

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
   pass
         

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