#
# header comment!
#
import sqlite3
import objecttier

##################################################################  
#
# main
#
print("Project 2: Movie Database App (N-Tier)")
print("CS 341, Spring 2025")
print()
print("This application allows you to analyze various")
print("aspects of the MovieLens database.")
print()

dbName = input("Enter the name of the database you would like to use: ")
developer_mode = False
dbName = "MovieLens-100K.db" if developer_mode else dbName
db_conn = sqlite3.connect(dbName)

print()
print("Successfully connected to the database!")

# This command prints the general statistics.
def command_one(db_conn):
    print("\nGeneral Statistics:")
    print(f"  Number of Movies: {objecttier.num_movies(db_conn):,}")
    print(f"  Number of Reviews: {objecttier.num_reviews(db_conn):,}")


# Retrieves all the movies and prints it out bro
def command_two(db_conn):
    print()
    print("Enter the name of the movie to find (wildcards _ and % allowed): ")
    pattern = input().strip()
    movies = objecttier.get_movies(db_conn, pattern)
    print("\nNumber of Movies Found:", len(movies))
    

    # If there are movies, then let's display it
    if movies:
        if len(movies) > 100:
            print("\nThere are too many movies to display (more than 100). Please narrow your search and try again.")
            return 
        print()
        for movie in movies:
            print(f"{movie.Movie_ID} : {movie.Title} ({movie.Release_Year})")


# This just prints out the movie details given an id
def command_three(db_conn):
    print()
    print("Enter a movie ID: ")
    movie_id = input().strip()
    movie = objecttier.get_movie_details(db_conn, movie_id) 

    if movie is None:
        print("\nNo movie matching that ID was found in the database.")
    else:
        print(f"\n{movie.Movie_ID} : {movie.Title}")
        print(f"  Release date: {movie.Release_Date}")
        print(f"  Runtime: {movie.Runtime} (minutes)")
        print(f"  Original language: {movie.Original_Language}")
        print(f"  Budget: ${movie.Budget:,} (USD)")
        print(f"  Revenue: ${movie.Revenue:,} (USD)")
        print(f"  Number of reviews: {movie.Num_Reviews}")
        print(f"  Average rating: {movie.Avg_Rating:.2f} (0-10)")

        genres = ""
        for i in range(len(movie.Genres)):
            genres += movie.Genres[i]
            genres += ','
            if i < len(movie.Genres) - 1:
                genres += ' '
        print(f"  Genres: {genres}")

        companies = ""
        for i in range(len(movie.Production_Companies)):
            companies += movie.Production_Companies[i]
            companies += ','
            if i < len(movie.Production_Companies) - 1:
                companies += ' '

        print(f"  Production companies: {companies}")
        print(f"  Tagline: {movie.Tagline}")


# This function prints out the top movies based on the given min and num reviews...
def command_four(db_conn):
    N = int(input("\nEnter a value for N: "))

    if N <= 0:
        print("Please enter a positive value for N.")
        return

    min_num_reviews = int(input("Enter a value for the minimum number of reviews: "))

    if min_num_reviews <= 0:
        print("Please enter a positive value for the minimum number of reviews.")
        return

    movies = objecttier.get_top_N_movies(db_conn, N, min_num_reviews)

    if not movies:
        print("\nNo movies were found that fit the criteria.")
        return

    if len(movies) > 100:
        print("\nThere are too many movies to display (more than 100). Please narrow your search and try again.")
        return 
    
    print()
    for movie in movies:
        print(f"{movie.Movie_ID} : {movie.Title} ({movie.Release_Year}), Average rating = {movie.Avg_Rating:.2f} ({movie.Num_Reviews} reviews)")


# Allows a user to insert a new review into the database, wow!
def command_five(db_conn):
    new_rating = int(input(("\nEnter a value for the new rating (0-10): ")))

    if not (0 <= new_rating <= 10):
        print("Invalid rating. Please enter a value between 0 and 10 (inclusive).")
        return
    
    movie_id = input("Enter a movie ID: ").strip()

    return_value = objecttier.add_review(db_conn, movie_id, new_rating)

    print()
    if return_value == 0:
        print("No movie matching that ID was found in the database.")
    else:
        print("Rating was successfully inserted into the database.")

# Adds a new tagline to a movie
def command_six(db_conn):
    new_tagline = input("\nEnter a tagline: ")
    movie_id = input("Enter a movie ID: ").strip()
    return_value = objecttier.set_tagline(db_conn, movie_id, new_tagline)

    print()
    if return_value == 0:
        print("No movie matching that ID was found in the database.")
    else:
        print("Tagline was successfully set in the database.")

while True:
    print()
    print("Select a menu option: ")
    print("  1. Print general statistics about the database")
    print("  2. Find movies matching a pattern for the name")
    print("  3. Find details of a movie by movie ID")
    print("  4. Top N movies by average rating, with a minimum number of reviews")
    print("  5. Add a new review for a movie")
    print("  6. Set the tagline of a movie")
    print("or x to exit the program.")
    print("Your choice --> ", end='')
    cmd = input().strip()

    if cmd == 'x':
        break
    

    try:
        choice = int(cmd)
        if choice <= 0 or choice >= 7:
            raise Exception
        
        if choice == 1:
            # Print general statistics
            command_one(db_conn)
        elif choice == 2:
            # List the movies given a pattern!
            command_two(db_conn)
        elif choice == 3:
            # Given a movie ID, display all the details bro...
            command_three(db_conn)
        elif choice == 4:
            # Print out a rating given N and minimum number of reviews
            command_four(db_conn)
        elif choice == 5:
            # Adds a new rating to an existing movie
            command_five(db_conn)
        elif choice == 6:
            # Adds a new tagline to an already existing movie
            command_six(db_conn)

    except ValueError:
        print("\nError, unknown command, try again...")

print("\nExiting program.")