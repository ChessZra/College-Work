# John Ezra See
# 02/04/2025
# A simple query python program for interacting with databases using the SQLITE3 library.

import sqlite3
import matplotlib.pyplot as plt
from datetime import datetime

DB_PATH = 'C:\\Users\\Ezra\\Downloads\\chicago-traffic-cameras.db'
DB_PATH = 'chicago-traffic-cameras.db'

##################################################################  
#
# print_stats
#
# Given a connection to the database, executes various
# SQL queries to retrieve and output basic stats.
#
def print_stats(db_conn):
    db_cursor = db_conn.cursor()
    
    print("General Statistics:")
    
    db_cursor.execute("SELECT COUNT(*) FROM RedCameras;")
    row = db_cursor.fetchone()
    print("  Number of Red Light Cameras:", f"{row[0]:,}")
    
    db_cursor.execute("SELECT COUNT(*) FROM SpeedCameras")
    row = db_cursor.fetchone()
    print("  Number of Speed Cameras:", f"{row[0]:,}")

    db_cursor.execute("SELECT COUNT(*) FROM RedViolations")
    row = db_cursor.fetchone()
    print("  Number of Red Light Camera Violation Entries:", f"{row[0]:,}")

    db_cursor.execute("SELECT COUNT(*) FROM SpeedViolations")
    row = db_cursor.fetchone()
    print("  Number of Speed Camera Violation Entries:", f"{row[0]:,}")

    db_cursor.execute("SELECT min(v.Violation_Date), max(v.Violation_Date) FROM SpeedViolations v")
    row = db_cursor.fetchone()
    print(f"  Range of Dates in the Database: {row[0]} - {row[1]}")

    db_cursor.execute("SELECT SUM(Num_Violations) FROM RedViolations")
    row = db_cursor.fetchone()
    print("  Total Number of Red Light Camera Violations:", f"{row[0]:,}")

    db_cursor.execute("SELECT SUM(Num_Violations) FROM SpeedViolations")
    row = db_cursor.fetchone()
    print("  Total Number of Speed Camera Violations:", f"{row[0]:,}")

# Query intersections matching user input with wildcards, ordered by name (A-Z).  
def command_one(db_conn):
    print()
    intersection = input("Enter the name of the intersection to find (wildcards _ and % allowed): ")
    
    db_cursor = db_conn.cursor()
    # We are going to use parameterization instead of f-string, it turns out that it's to avoid SQL injections...
    db_cursor.execute("SELECT * FROM Intersections WHERE Intersection LIKE ? ORDER BY Intersection", (intersection,))
    row = db_cursor.fetchall()
    for id, intersection_name in row:
        print(f"{id} : {intersection_name}")

    if not row:
        print("No intersections matching that name were found.")

# Query red light and speed cameras at the given intersection, ordered by camera ID.  
# Display each camera's ID and address, or print messages if none are found.  
def command_two(db_conn):
    print()
    db_cursor = db_conn.cursor()
    intersection = input("Enter the name of the intersection (no wildcards allowed): ")

    # Red cameras:
    db_cursor.execute("""
        SELECT Camera_ID, Address FROM Intersections i 
        INNER JOIN RedCameras r ON i.Intersection_ID = r.Intersection_ID 
        WHERE i.Intersection = ?
        GROUP BY r.Camera_ID \
        ORDER BY CAMERA_ID""", (intersection,))
    row = db_cursor.fetchall()
    print()
    if row:
        print("Red Light Cameras:")
        for id, intersection_name in row:
            print(f"  {id} : {intersection_name}")
    else:
        print("No red light cameras found at that intersection.")
    print()

    # Speed Cameras
    db_cursor.execute("""
        SELECT Camera_ID, Address FROM Intersections i 
        INNER JOIN SpeedCameras r ON i.Intersection_ID = r.Intersection_ID 
        WHERE i.Intersection = ? 
        GROUP BY r.Camera_ID 
        ORDER BY CAMERA_ID""", (intersection,))
    row = db_cursor.fetchall()
    if row:
        print("Speed Cameras:")
        for id, intersection_name in row:
            print(f"  {id} : {intersection_name}")
    else:
        print("No speed cameras found at that intersection.")

# Query violations for the given date, calculate percentages, and display results, or show an error if invalid.
def command_three(db_conn):
    print()
    db_cursor = db_conn.cursor()
    date = input("Enter the date that you would like to look at (format should be YYYY-MM-DD): ")
    db_cursor.execute("SELECT SUM(Num_Violations) FROM RedViolations WHERE Violation_Date = ?", (date,))
    red_violations = db_cursor.fetchall()[0][0]

    db_cursor.execute(f"SELECT SUM(Num_Violations) FROM SpeedViolations WHERE Violation_Date = ?", (date,))
    speed_violations = db_cursor.fetchall()[0][0]

    if red_violations is None and speed_violations is None:
        print("No violations on record for that date.")
    else:
        total = red_violations + speed_violations
        percent = red_violations / total * 100
        print("Number of Red Light Violations:", f"{red_violations:,}", f"({percent:.3f}%)")
        percent = speed_violations / total * 100
        print("Number of Speed Violations:", f"{speed_violations:,}", f"({percent:.3f}%)")
        print("Total Number of Violations:", f"{total:,}")

# Query the number of red light and speed cameras at each intersection and the total number of cameras in Chicago.
def command_four(db_conn):
    print()
    db_cursor = db_conn.cursor()
    # Red light cameras at each intersection:
    db_cursor.execute("""
        SELECT i.Intersection, i.Intersection_ID, COUNT(*) AS number_of_cameras 
        FROM Intersections i 
        JOIN RedCameras r ON i.Intersection_ID = r.Intersection_ID 
        GROUP BY i.Intersection_ID 
        ORDER BY number_of_cameras DESC
    """)

    red_cameras = db_cursor.fetchall()
    
    db_cursor.execute("SELECT COUNT(*) FROM RedCameras")
    total_red_cameras = db_cursor.fetchone()[0]

    print("Number of Red Light Cameras at Each Intersection")
    for intersection_name, intersection_id, number_of_cameras in red_cameras:
        print(f"  {intersection_name} ({intersection_id}) : {number_of_cameras:,} ({(number_of_cameras / total_red_cameras * 100):.3f}%)")

    # Speed cameras at each interesction:
    db_cursor.execute("""
        SELECT i.Intersection, i.Intersection_ID, COUNT(*) AS number_of_cameras 
        FROM Intersections i 
        JOIN SpeedCameras r ON i.Intersection_ID = r.Intersection_ID 
        GROUP BY i.Intersection_ID 
        ORDER BY number_of_cameras DESC
    """)

    speed_cameras = db_cursor.fetchall()
    
    db_cursor.execute("SELECT COUNT(*) FROM SpeedCameras")
    total_speed_cameras = db_cursor.fetchone()[0]

    print()
    print("Number of Speed Cameras at Each Intersection")
    for intersection_name, intersection_id, number_of_cameras in speed_cameras:
        print(f"  {intersection_name} ({intersection_id}) : {number_of_cameras:,} ({(number_of_cameras / total_speed_cameras * 100):.3f}%)")

# Query the number of red light and speed violations per intersection for the given year, along with the total violations in Chicago.
def command_five(db_conn):
    print()
    year = input("Enter the year that you would like to analyze: ")
    db_cursor = db_conn.cursor()

    # Red Light Violations at each intersection:
    db_cursor.execute("""
        SELECT i.Intersection, i.Intersection_ID, SUM(v.Num_Violations) as total_violations 
        FROM RedViolations v 
        JOIN RedCameras c ON v.Camera_ID = c.Camera_ID  
        JOIN Intersections i ON i.Intersection_ID = c.Intersection_ID 
        WHERE strftime('%Y', Violation_Date) = ?
        GROUP BY i.Intersection_ID 
        ORDER BY total_violations DESC 
    """, (year,))
    red_violations = db_cursor.fetchall()

    db_cursor.execute(f"SELECT SUM(Num_Violations) FROM RedViolations WHERE strftime('%Y', Violation_Date) = ?", (year,))
    total_red_violations = db_cursor.fetchone()[0] 

    print()
    print("Number of Red Light Violations at Each Intersection for", year)
    if total_red_violations is not None and total_red_violations > 0:
        for intersection_name, intersection_id, total_violations in red_violations:
            print(f"  {intersection_name} ({intersection_id}) : {total_violations:,} ({(total_violations / total_red_violations * 100):.3f}%)")
        print(f"Total Red Light Violations in {year} : {total_red_violations:,}")
    else:
        print("No red light violations on record for that year.")
    print()

    # Speed Violations at each intersection:
    db_cursor.execute("""
        SELECT i.Intersection, i.Intersection_ID, SUM(v.Num_Violations) as total_violations 
        FROM SpeedViolations v 
        JOIN SpeedCameras c ON v.Camera_ID = c.Camera_ID  
        JOIN Intersections i ON i.Intersection_ID = c.Intersection_ID 
        WHERE strftime('%Y', Violation_Date) = ?
        GROUP BY i.Intersection_ID 
        ORDER BY total_violations DESC 
        """, (year,))
    speed_violations = db_cursor.fetchall()

    db_cursor.execute(f"SELECT SUM(Num_Violations) FROM SpeedViolations WHERE strftime('%Y', Violation_Date) = ?", (year,))
    total_speed_violations = db_cursor.fetchone()[0]

    print("Number of Speed Violations at Each Intersection for", year)
    if total_speed_violations is not None and total_speed_violations > 0:
        for intersection_name, intersection_id, total_violations in speed_violations:
            print(f"  {intersection_name} ({intersection_id}) : {total_violations:,} ({(total_violations / total_speed_violations * 100):.3f}%)")
        print(f"Total Speed Violations in {year} : {total_speed_violations:,}")
    else:
        print("No speed violations on record for that year.")

# Check camera ID, output violations by year, and plot if user confirms.
def command_six(db_conn):
    print()
    db_cursor = db_conn.cursor()
    camera_id = input("Enter a camera ID: ")

    # SELECT in SELECT after combining both tables.
    db_cursor.execute("""
        SELECT STRFTIME('%Y', Violation_Date) AS year, SUM(Num_Violations)
        FROM (
            SELECT * FROM RedViolations
            UNION ALL
            SELECT * FROM SpeedViolations
            )
        WHERE CAMERA_ID = ?
        GROUP BY year
        ORDER BY year                        
    """, (camera_id,))

    rows = db_cursor.fetchall()

    if len(rows) == 0:
        print("No cameras matching that ID were found in the database.")
    else:
        print("Yearly Violations for Camera", camera_id)
        for year, number_violations in rows:
            print(f"{year} : {number_violations:,}")
        print()
        should_plot = True if input("Plot? (y/n) ") == 'y' else False 
        
        if should_plot: 
            fig, ax = plt.subplots()
            
            ax.plot([year for year, viol in rows], [viol for year, viol in rows], )
            ax.set_xlabel("Year")
            ax.set_ylabel("Number of Violations")
            ax.set_title("Yearly Violations for Camera " + camera_id)
            plt.show()

# Check camera ID and year, output monthly violations, and plot if user confirms.
def command_seven(db_conn):
    print()
    db_cursor = db_conn.cursor()
    camera_id = input("Enter a camera ID: ")

    # Check if camera_id exists
    if len(db_cursor.execute("""SELECT *
        FROM (
            SELECT * FROM RedViolations
            UNION ALL
            SELECT * FROM SpeedViolations
            )
        WHERE Camera_ID = ?""", (camera_id,)).fetchmany(size=2)) == 0:
        print("No cameras matching that ID were found in the database.")
        return

    year = input("Enter a year: ")

    # Monthly violations from both red and speeding cameras:
    db_cursor.execute("""
        SELECT STRFTIME('%m', Violation_Date) as month, STRFTIME('%Y', Violation_Date) as year, SUM(Num_Violations) as total_violations
        FROM (
            SELECT * FROM RedViolations
            UNION ALL
            SELECT * FROM SpeedViolations
            )
        WHERE Camera_ID = ? AND year = ?
        GROUP BY month
        ORDER BY month             
    """, (camera_id, year))

    rows = db_cursor.fetchall()
    print(f"Monthly Violations for Camera {camera_id} in {year}")
    for month, year, violations in rows:
        print(f"{month}/{year} : {violations:,}")
    print()

    should_plot = True if input("Plot? (y/n) ") == 'y' else False 

    if should_plot: 
        fig, ax = plt.subplots()
    
        ax.plot([month for month, year, violations in rows], [violations for month, year, violations in rows])
        ax.set_xlabel("Month")
        ax.set_ylabel("Number of Violations")
        ax.set_title(f"Monthly Violations for Camera {camera_id} ({year})")
        plt.show()

# Query daily violations for the year, show first/last 5 days, and plot if user confirms.
def command_eight(db_conn):
    # Example usage:
    # January 1 => 1
    # December 25 => 365
    def date_to_day(date):
        year, month, day = map(int, date.split('-'))
        res = (datetime(year, month, day) - datetime(year, 1, 1)).days + 1
        return res

    print()
    year = input("Enter a year: ")
    db_cursor = db_conn.cursor()

    # Red Light Violations:
    db_cursor.execute("""
        SELECT Violation_Date, SUM(Num_Violations)
        FROM RedViolations
        WHERE STRFTIME('%Y', Violation_Date) = ?
        GROUP BY Violation_Date
        ORDER BY Violation_Date
    """, (year,))
    red_violations = db_cursor.fetchall()
    
    print("Red Light Violations:")
    for date, number_violations in (red_violations[:5] + red_violations[-5:]):
        print(date, number_violations)

    # Speed Violations:
    db_cursor.execute("""
        SELECT Violation_Date, SUM(Num_Violations)
        FROM SpeedViolations
        WHERE STRFTIME('%Y', Violation_Date) = ?
        GROUP BY Violation_Date
        ORDER BY Violation_Date
    """, (year,))
    speed_violations = db_cursor.fetchall()
    print("Speed Violations:")
    for date, number_violations in (speed_violations[:5] + speed_violations[-5:]):
        print(date, number_violations)
    print()

    # Start plotting the data
    should_plot = True if input("Plot? (y/n) ") == 'y' else False 

    if should_plot: 
        fig, ax = plt.subplots()

        days_of_year = list(range(1, 366))  
        red_dict = {date_to_day(date): violations for date, violations in red_violations}
        speed_dict = {date_to_day(date): violations for date, violations in speed_violations}

        red_violations = [red_dict.get(day, 0) for day in days_of_year]
        speed_violations = [speed_dict.get(day, 0) for day in days_of_year]

        ax.plot(days_of_year, red_violations, color="red", label="Red Light")
        ax.plot(days_of_year, speed_violations, color="orange", label="Speed")

        ax.set_xlabel("Day")
        ax.set_ylabel("Number of Violations")
        ax.set_title(f"Violations Each Day of {year}")

        ax.legend()

        plt.show()

# Query red light and speed cameras on the given street, display camera details, and plot if user confirms.
def command_nine(db_conn):
    print()
    street = input("Enter a street name: ")
    db_cursor = db_conn.cursor()
    pattern = f"%{street}%"
    
    db_cursor.execute("""
        SELECT Camera_ID, Address, Latitude, Longitude
        FROM RedCameras
        WHERE Address LIKE ? COLLATE NOCASE
        ORDER BY Camera_ID
    """, (pattern,))
    red_cameras = db_cursor.fetchall()
    
    db_cursor.execute("""
        SELECT Camera_ID, Address, Latitude, Longitude
        FROM SpeedCameras
        WHERE Address LIKE ? COLLATE NOCASE
        ORDER BY Camera_ID
    """, (pattern,))
    speed_cameras = db_cursor.fetchall()
    
    if not red_cameras and not speed_cameras:
        print("There are no cameras located on that street.")
        return
    print()

    print(f"List of Cameras Located on Street: {street}")
    print("  Red Light Cameras:")
    for camera_id, address, lat, lon in red_cameras:
        print(f"    {camera_id} : {address} ({lat}, {lon})")

    print("  Speed Cameras:")
    for camera_id, address, lat, lon in speed_cameras:
        print(f"    {camera_id} : {address} ({lat}, {lon})")
    print()

    # Start plotting the data
    should_plot = True if input("Plot? (y/n) ") == 'y' else False 

    if should_plot:
        image = plt.imread("chicago.png")
        xydims = [-87.9277, -87.5569, 41.7012, 42.0868]
        plt.imshow(image, extent=xydims)
        plt.title("Cameras on Street: " + street)
        
        lons = [lon for camera_id, address, lat, lon in red_cameras]
        lats = [lat for camera_id, address, lat, lon in red_cameras]
        plt.scatter(lons, lats, color='red', label='Red Light Cameras', alpha=0.5)

        lons = [lon for camera_id, address, lat, lon in speed_cameras]
        lats = [lat for camera_id, address, lat, lon in speed_cameras]
        plt.scatter(lons, lats, color='orange', label='Speed Cameras', alpha=0.5)
        
        for camera_id, address, lat, lon in (red_cameras + speed_cameras):
            plt.annotate(camera_id, (lon, lat))
        
        plt.legend()
        plt.xlim(xydims[:2])
        plt.ylim(xydims[2:])
        plt.show()

# Main application thread:
if __name__ == '__main__':
    db_conn = sqlite3.connect(DB_PATH)

    print("Project 1: Chicago Traffic Camera Analysis")
    print("CS 341, Spring 2025")
    print()
    print("This application allows you to analyze various")
    print("aspects of the Chicago traffic camera database.")
    print()
    print_stats(db_conn)

    while True:
        print()
        print("Select a menu option: ")
        print("  1. Find an intersection by name")
        print("  2. Find all cameras at an intersection")
        print("  3. Percentage of violations for a specific date")
        print("  4. Number of cameras at each intersection")
        print("  5. Number of violations at each intersection, given a year")
        print("  6. Number of violations by year, given a camera ID")
        print("  7. Number of violations by month, given a camera ID and year")
        print("  8. Compare the number of red light and speed violations, given a year")
        print("  9. Find cameras located on a street")
        print("or x to exit the program.")

        query = input("Your choice --> ")

        try:
            query = int(query)

            if query == 1:
                command_one(db_conn)
            elif query == 2:
                command_two(db_conn)
            elif query == 3:
                command_three(db_conn)
            elif query == 4:
                command_four(db_conn)
            elif query == 5:
                command_five(db_conn)
            elif query == 6:
                command_six(db_conn)
            elif query == 7:
                command_seven(db_conn)
            elif query == 8:
                command_eight(db_conn)
            elif query == 9:
                command_nine(db_conn)
            else:
                raise ValueError

        except ValueError:
            if query == 'x':
                break
            print("Error, unknown command, try again...")
        
    print("Exiting program.")

