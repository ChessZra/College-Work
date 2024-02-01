# makefile here is ran in my local windows machine
# This is not dedicated for the zybooks submission:

build: main.c
	gcc main.c -o main.exe

test: test.c
	gcc test.c -o test.exe

# In a UNIX operating system do, ./main.exe < input.txt
run: build
	.\main.exe

run_test: test
	./test.exe

# In UNIX operating system do, rm -f main.exe...
clean:
	del -f main.exe
	del -f test.exe