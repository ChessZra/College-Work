#
# header comment!
#
import sqlite3
import objecttier

dbConn = sqlite3.connect("MovieLens-100K.db")
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

print()
print("Successfully connected to the database!")

print()
print("Select a menu option: ")
print("  1. Print general statistics about the database")
print("  2. Find movies matching a pattern for the name")
print("  3. Find details of a movie by movie ID")
print("  4. Top N movies by average rating, with a minimum number of reviews")
print("  5. Add a new review for a movie")
print("  6. Set the tagline of a movie")
print("or x to exit the program.")
cmd = input("Your choice --> ")
print()

obj = objecttier.get_movie_details(dbConn, 603)
print(obj.Title)
print(obj.Release_Date)
print(obj.Runtime)
print(obj.Original_Language)
print(obj.Budget)
print(obj.Revenue)
print(obj.Num_Reviews)
print(obj.Avg_Rating)
print(obj.Tagline)

print("Exiting program.")