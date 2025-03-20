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
  let filename = System.Console.ReadLine()
  let contents = System.IO.File.ReadLines(filename)
  let ridedata = ParseInput contents

  printfn ""
  printfn "Number of Trips: %A" 0
  printfn ""
  
  printfn "Number of Riders Identifying as Male: %A (%A%%)" 0 0.0
  printfn "Number of Riders Identifying as Female: %A (%A%%)" 0 0.0
  printfn ""
  
  printfn "Average Age: %A" 0.0
  printfn ""
  
  printfn "Ride Durations: "
  printfn "   0-30 mins: %A (%A%%)" 0 0.0
  printfn "   30-60 mins: %A (%A%%)" 0 0.0
  printfn "   60-120 mins: %A (%A%%)" 0 0.0
  printfn "   > 2 hours: %A (%A%%)" 0 0.0
  printfn ""
  
  printfn "Histogram of Start Times:"
  printfn "   0: 0"
  printfn "   1: 0"
  printfn "   2: 0"
  printfn "   3: 0"
  printfn "   4: 0"
  printfn "   5: 0"
  printfn "   6: 0"
  printfn "   7: 0"
  printfn "   8: 0"
  printfn "   9: 0"
  printfn "   10: 0"
  printfn "   11: 0"
  printfn "   12: 0"
  printfn "   13: 0"
  printfn "   14: 0"
  printfn "   15: 0"
  printfn "   16: 0"
  printfn "   17: 0"
  printfn "   18: 0"
  printfn "   19: 0"
  printfn "   20: 0"
  printfn "   21: 0"
  printfn "   22: 0"
  printfn "   23: 0"

  printfn ""
  printfn "Exiting program."
  0