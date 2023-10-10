build:
	rm -f app.exe
	gcc app.c MinPopVote.c -o app.exe

run:
	./app.exe

run_quiet:
	./app.exe -q

valgrind:
	valgrind -s --tool=memcheck --leak-check=yes --track-origins=yes ./app.exe

# TODO: Task 3 - extend the makefile for the following targets:
#         - run_fast to execute the program app.exe with fast mode ON
#           and default values for all other command-line arguments. 
#         - at least 2 additional run targets for app.exe, similar 
#           to run_quiet but with other meaningful combinations of 
#           program settings set by command-line arguments
#         - built_test to compile test.c with the functions in 
#           MinPopVote.c and build the executable test.exe
#         - run_test to exectue the testing suite test.exe 
#         - any additional targets you find useful

