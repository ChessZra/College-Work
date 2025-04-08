// John Ezra See
// 04/08/2025
// Project 3: Divvy Rides Data Analysis with F#
// Brief Description: This project allows the user to analyze 
// statistics about divvy rides in Chicago such as the users, their gender, etc.

// --------------------------------------------------------------
// 
// ParseLine and ParseInput
//
// Given a sequence of strings representing Divvy data, 
// parses the strings and returns a list of lists. Each
// sub-list denotes one bike ride.
// 
// Example:
//   [ [21864678; 6035; 3000; 23; 317; 338; 1; 1; 1974]; ... ]
//
// The values are:
//    trip_id
//    bike_id
//    trip_duration   (seconds)
//    starting_hour   (between 0 and 23)
//    from_station_id
//    to_station_id
//    is_subscriber   (1 if yes, 0 if no)
//    gender          (0 if not specified, 1 if identifies as male, 2 if identifies as female)
//    birth_year      (0 if not specified)
// 
let ParseLine (line:string) = 
  let tokens = line.Split(',')
  let ints = Array.map System.Int32.Parse tokens
  Array.toList ints

let rec ParseInput lines = 
  let rides = Seq.map ParseLine lines
  Seq.toList rides

// Given ridedata, find the number of lines there is
let numberOfTrips L = 
  List.length L

// Given ridedata, find the number of people that identify as males
let numberOfMales L = 
  List.length (List.filter (fun (x: int list) -> x.[7] = 1) L)

// Given ridedata, find the number of people that identify as females
let numberOfFemales L = 

  let rec helper LL count = 
    match LL with 
    | [] -> count // If the list is empty, return count
    | (head: int list) :: tail -> 
        if head.[7] = 2 then // if the rider identifies as female (gender = 2)
          helper tail (count + 1) // increment the count
        else 
          helper tail count // continue without incrementing because the user is not a female

  helper L 0

// Given ridedata, accumulate all the ages and divide it to the total number of people
// that provided their ages in order to get the average
let averageAge L = 
  let current_year = 2025 // Set the current year for age calculation 
  let rec helper LL total count =
    match LL with
    | [] -> 
      if count = 0 then // Return 0 if no valid age is found, prevents division by 0
        0.0
      else // calculate and return the average
        (float total) / (float count)
    | (head: int list) :: tail -> 
        if head.[8] = 0 then // skip entries where the birth year is not provided
          helper tail total count
        else // increment total by the age, also increment count by 1
          helper tail (total + (current_year - head.[8])) (count + 1)
  helper L 0 0

// This returns a list of 4 where [0;0;0;0] 
// the first element corresponds to 0-30 mins, 30-60 mins, 60-120 mins, > 2 hours
let rideDurations L = 
  
  // recursively process the list of rides
  let rec helper LL t1 t2 t3 t4 = 
    match LL with
    | [] -> [t1; t2; t3; t4] // return the counts for each category when empty
    | (head: _ list) :: tail -> 
      if head.[2] < 0 || head.[2] > 86400 then // invalid durations (negative or above 24 hours)
        helper tail t1 t2 t3 t4
      else if head.[2] <= 1800 then // 0-30 minutes, increment t1
        helper tail (t1 + 1) t2 t3 t4
      else if head.[2] <= 3600 then // 30-60 minutes, increment t2
        helper tail t1 (t2 + 1) t3 t4 
      else if head.[2] <= 7200 then // 60-120 minutes, increment t3
        helper tail t1 t2 (t3 + 1) t4
      else // otherwise, increment t4
        helper tail t1 t2 t3 (t4 + 1)

  helper L 0 0 0 0

// We can either return a list of size 24 (one pass)
// Or call this function Histogram given an index (total of 24 passes)
// We will use the latter approach:
// Get the number of total calls in this hour
let getRidesInStartingHour L starting_hour = 
  List.length (List.filter (fun (x: _ list) -> x.[3] = starting_hour) L)

// --------------------------------------------------------------
// main function
// 
[<EntryPoint>]
let main argv =

  printfn "Project 3: Divvy Rides Data Analysis with F#"
  printfn "CS 341, Spring 2025"
  printfn ""
  printfn "This application allows you to analyze and visualize"
  printfn "information about Divvy bike rides in Chicago, such as"
  printfn "the number of male/female riders, the average age, etc."
  printfn ""

  printf "Enter the name of the file with the Divvy ride data: "
  // Ask user for input file then parse it to list of lists
  let filename = System.Console.ReadLine()
  let contents = System.IO.File.ReadLines(filename)
  let ridedata = ParseInput contents

  // Get the number of trips section
  let number_of_trips = numberOfTrips ridedata
  printfn ""
  printfn "Number of Trips: %A" number_of_trips
  printfn ""

  // Get the number of males and females section
  let number_of_males = numberOfMales ridedata
  let number_of_females = numberOfFemales ridedata

  printfn "Number of Riders Identifying as Male: %A (%A%%)" number_of_males ((float number_of_males)/(float number_of_trips) * 100.0)
  printfn "Number of Riders Identifying as Female: %A (%A%%)" number_of_females ((float number_of_females)/(float number_of_trips) * 100.0) 
  printfn ""

  // Get the average age section
  let average_age = averageAge ridedata

  printfn "Average Age: %A" average_age
  printfn ""
  
  // Get the ride durations section
  let ride_durations = rideDurations ridedata
  printfn "Ride Durations: "
  printfn "   0-30 mins: %A (%A%%)" ride_durations.[0] ((float ride_durations.[0]) / (float number_of_trips) * 100.0)
  printfn "   30-60 mins: %A (%A%%)" ride_durations.[1] ((float ride_durations.[1]) / (float number_of_trips) * 100.0)
  printfn "   60-120 mins: %A (%A%%)" ride_durations.[2] ((float ride_durations.[2]) / (float number_of_trips) * 100.0)
  printfn "   > 2 hours: %A (%A%%)" ride_durations.[3] ((float ride_durations.[3]) / (float number_of_trips) * 100.0)
  printfn ""
  
  // Display the histogram section
  printfn "Histogram of Start Times:"
  let rec histogramHelper current_hour = 
    if current_hour < 24 then
      let number_rides = getRidesInStartingHour ridedata current_hour
      let ast = number_rides / 100
      printf "   %A: %s%A\n" current_hour (String.replicate ast "*") number_rides
      histogramHelper (current_hour + 1)
  histogramHelper 0

  // Program end
  printfn ""
  printfn "Exiting program."
  0