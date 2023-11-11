build:
	del -f app.exe
	gcc app.c MinPopVote.c -o app.exe

run:
	./app.exe

run_quiet:
	./app.exe -q

valgrind:
	valgrind -s --tool=memcheck --leak-check=yes --track-origins=yes ./app.exe

run_fast:
	./app.exe -f

run_test1:
	./app.exe -y 1828

run_test2:
	./app.exe -y 1844 -f

built_test:
	gcc test.c MinPopVote.c -o test.exe

run_test:
	./test.exe