/* -----------------------------------------------------------------------------------
Program 1: Ciphers Project
Course: CS 251, Spring 2024, UIC
System: Advanced zyLab
Author: ChessZra
- -               - -
Description: Encryption and decryption are pretty essential. This is just a basic
implementation of these concepts - an abstract way to implement the Caesar cipher
and Vigenère cipher.
------------------------------------------------------------------------------------- */
// Preproccesor directives:
#include <cctype>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

const string ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

// Function prototypes at the top of the file for function decomposition

/**
 * Print instructions for using the program.
 */
void printMenu();

/**
 * Returns the 0-based index in the English alphabet where `c` appears,
 * or -1 if `c` is not an uppercase letter in the alphabet.
 *
 * For example:
 *  - `findIndexInAlphabet('A')` returns 0
 *  - `findIndexInAlphabet('D')` returns 3
 *  - `findIndexInAlphabet('+')` returns -1
 *  - `findIndexInAlphabet('a')` returns -1
 */
int findIndexInAlphabet(char c);

/**
 * Returns `c` rotated by `amount` many characters forward. If we run out
 * of letters in the alphabet, wrap around back to 'A'. This method
 * assumes that `c` is an uppercase letter.
 * For example:
 *  - `rot('A', 0)` returns 'A'
 *  - `rot('A', 1)` returns 'B'
 *  - `rot('Z', 1)` returns 'A'
 *  - `rot('A', 10)` returns 'K'
 *  - `rot('J', 25)` returns 'I'
 */
char rot(char c, int amount);

/**
 * Returns a new string in which every character has been rotated by `amount`
 * letters. Characters that are not uppercase letters are converted to UPPERCASE.
 * For example:
 *  `rot("A", 0)` returns "A"
 *  `rot("AA", 3)` returns "DD"
 *  `rot("HELLO", 0)` returns "HELLO"
 *  `rot("HELLO", 1)` returns "IFMMP"
 */
string rot(string line, int amount);

// Vigenère Cipher Encoder:
string encryptVig(string textToEncrypt, string key);

// Main algorithm for Cesar Cipher Decryption:
// The result vector is decryptedWords.
void decryptCipher(string textToDecrypt, unordered_set<string> dictionary, 
                   vector<string>& decryptedWords);

int main() {
    string command;

    cout << "Welcome to Ciphers!" << endl;
    cout << "-------------------" << endl;
    cout << endl;

    do {
        printMenu();
        cout << endl
             << "Enter a command (case does not matter): ";

        // Use getline for all user input to avoid needing to handle
        // input buffer issues relating to using both >> and getline
        getline(cin, command);
        cout << endl;
        
        // Load the dictionary, let's store it in a set for O(1) lookup:
        ifstream inputFile;
        string buffer;
        unordered_set<string> dictionary;
        inputFile.open("dictionary.txt");
        while (getline(inputFile, buffer)) {
            dictionary.insert(buffer);
        }

        command = tolower(command[0]);
        if (command == "c") { // Encrypt with Caesar Cipher:
            cout << "Enter the text to encrypt:" << endl;
            string textToEncrypt, rotateBy;
            getline(cin, textToEncrypt);
            cout << "Enter the number of characters to rotate by:" << endl;
            getline(cin, rotateBy);
            cout << endl << rot(textToEncrypt, stoi(rotateBy)) << "\n\n";
        } else if (command == "v") { // Encrypt with Vigenère:
            cout << "Enter text to encrypt:" << endl;
            string textToEncrypt, key;
            getline(cin, textToEncrypt);
            cout << "Enter the Vigenère key:" << endl;
            getline(cin, key);
            cout << encryptVig(textToEncrypt, key) << "\n\n";
        } else if (command == "d") { // Decrypt with Caesar Cipher:
            cout << "Enter the text to Caesar-cipher decrypt:" << endl;
            string textToDecrypt;
            vector<string> decryptedWords;
            getline(cin, textToDecrypt);
            decryptCipher(textToDecrypt, dictionary, decryptedWords);
            for (auto word: decryptedWords) cout << word << endl;
            cout << endl;
        }

    } while (!(command == "x" || command == "X"));

    return 0;
}

void printMenu() {
    cout << "Ciphers Menu" << endl;
    cout << "------------" << endl;
    // Caesar Ciphers
    cout << "C - Encrypt with Caesar Cipher" << endl;
    cout << "D - Decrypt Caesar Cipher" << endl;
    // Vigenere
    cout << "V - Encrypt with Vigenère" << endl;
    // Utility
    // cout << "Z - Set Random Seed for testing" << endl;
    cout << "X - Exit Program" << endl;
}

int findIndexInAlphabet(char c) {
    return ALPHABET.find(c);
}

char rot(char c, int amount) {
    int index = findIndexInAlphabet(c);
    if (index == -1) return '0';
    return ALPHABET[(index + amount) % ALPHABET.size()];
}

string rot(string line, int amount) {
    string ret = "";
    for (int i = 0; i < line.size(); i++) {
        char letter = line[i];
        if (isalpha(letter)) {
            letter = rot(toupper(letter), amount);
        }
        ret += letter;
    }
    return ret;
}

// Helper Function for encryptVig(), convert to uppercase and remove characters 
// that are not letters.
string fixKey(string key) {
    string ret = "";
    for (int i = 0; i < key.size(); i++) {
        if (!isalpha(key[i])) continue;
        ret += toupper(key[i]);
    }
    return ret;
}

// Main algorithm for Vigenère Cipher Encoder:
string encryptVig(string textToEncrypt, string key) {
    string ret = "";
    key = fixKey(key);
    int keyIterator = 0;
    for (int i = 0; i < textToEncrypt.size(); i++) {
        char c = textToEncrypt[i];
        if (isalpha(c)) {
            int rotateBy = findIndexInAlphabet(key[keyIterator++ % key.size()]);
            c = rot(toupper(c), rotateBy);
        }
        ret += c;
    }
    return ret;
}

void decryptCipher(string textToDecrypt, unordered_set<string> dictionary, 
                   vector<string>& decryptedWords) {
    vector<string> words;
    string temp = "";
    // This for-loop converts the string textToDecrypt to a vector of uppercase words
    // separated by spaces.
    for (int i = 0; i < textToDecrypt.size(); i++) {
        if (textToDecrypt[i] == ' ' && temp.size() > 0) {
            words.push_back(temp);
            temp = "";
            continue;
        }
        if (!isalpha(textToDecrypt[i])) continue;
        temp += toupper(textToDecrypt[i]);
    }
    if (temp.size() > 0) words.push_back(temp);

    // This is where we perform a brute-force approach by trying all possibilities of
    // rotation, as we loop from 0 to 25. We then check if these rotated words are
    // found in the dictionary.
    for (int i = 0; i < 26; i++) {
        vector<string> rotatedWords;
        int foundInDictionary = 0;
        for (auto word: words) {
            string rotatedWord = rot(word, i);
            rotatedWords.push_back(rotatedWord);
            // We used an unordered_set here as we want O(1) lookup:
            if (dictionary.find(rotatedWord) != dictionary.end()) foundInDictionary++;
        }

        if (foundInDictionary > (words.size() / 2)) {
            string qualified = "";
            for (int j = 0; j < rotatedWords.size(); j++) {
                qualified += rotatedWords[j];
                if (j != rotatedWords.size() - 1) qualified += ' ';
            }
            decryptedWords.push_back(qualified);
        }
    }
};