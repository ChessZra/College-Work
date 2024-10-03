/* -----------------------------------------------------------------------------------
Program 1: Queue and Hashmap Implementation
Course: CS 342, Fall 2024, UIC
System: Windows 10
Author: John Ezra See
- -               - -
Description: This project is my own implementation of the Hashmap and Queue data
structures.
------------------------------------------------------------------------------------- */

public class GLProject {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Welcome to project 1");
		
		GenericQueue<Integer> myQueue = new GenericQueue<>(69);
		myQueue.print();
        Integer[] arr = {61, 24, 12, 41, 51};
        for (int i = 0; i < 5; i++) {
            myQueue.add(arr[i]);

        }
		myQueue.print();
	}
}
