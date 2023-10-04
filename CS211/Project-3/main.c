/* -----------------------------------------------------------------------------------
Program 3: Evil Word Guessing Game
Course: CS 211, Fall 2023, UIC
System: Advanced zyLab
Author: John Ezra See
- -               - -
Description: This program is an "evil" version of the hangman game. The idea is to
reduce the possibility of the user winning as much as possible. This is done through
certain algorithms that will supposedly make it harder for the user to guess the
correct word.
------------------------------------------------------------------------------------- */
// Preproccesor directives:
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

typedef struct Pattern_struct {
    char* pat;   // String pattern - exs: "hello", "-ell-", "-----".
    int count;   // Frequency of pattern in the current word list.
    int changes; // Number of occurences of new letter in this pattern.
} Pattern;

/** addWord:                                                                          - -
    This function modifies the dynamic heap-allocated array of C-strings ***words, by 
    allocating extra space when necessary. This function gets repeatedly called to add 
    words in the array.
    @param words    :   The dynamic heap-allocated array containing words (C-strings).
    @param numWords :   The number of elements in words array.
    @param maxWords :   The capacity of the words array.
    @param newWord  :   The word to be added to the words array.
    @return         :   None | modifies variables numWords, maxWords, words.          */
void addWord(char*** words, int* numWords, int* maxWords, char* newWord) {
    if (*numWords == *maxWords) {   // Case: The current words exceed the capacity, 
                                    // double the size of **words.
        char** newArray = (char**) malloc(sizeof(char*) * (*maxWords * 2));
        for (int i = 0; i < *numWords; i++) {
            newArray[i] = (*words)[i];
        } 
        free(*words);
        *words = newArray;
        *maxWords *= 2;
    }
    // Add + 1 because of the edge case '\0'
    char* newWordCopy = (char*) malloc(sizeof(char) * (strlen(newWord) + 1));   
    strcpy(newWordCopy, newWord);
    // Add the new word to the end of the array and update *numWords;
    (*words)[*numWords] = newWordCopy;
    // free(newWordCopy);
    *numWords += 1;
}

/** strNumMods:                                                                       - -
    This function calculates the count of characters that are different comparing two
    strings. For example:
        str1 = wands, str2 = wants,     returns 1
        str1 = magic, str2 = darkmagic, returns 8
    @param str1 :   A C-string that possibly represents any word. 
    @param str2 :   Another C-string that possibly represents any word. 
    @return     :   Integer representing the number of differences of the strings.    */
int strNumMods(char* str1, char* str2) {
    char* ptr1 = str1;
    char* ptr2 = str2;
    int charDiff = 0;
    while (*ptr1 != '\0' && *ptr2 != '\0') {
        charDiff += (*ptr1 != *ptr2);
        ptr1++;
        ptr2++;
    }
    while (*ptr1 != '\0') {
        ptr1++;
        charDiff++;
    }
    while (*ptr2 != '\0') {
        ptr2++;
        charDiff++;
    }
    return charDiff;
}

/** strNumInd:                                                                        - -
    This function returns the first index of where the two strings are different.
        str1 = wands, str2 = wants,     returns 3
        str1 = magic, str2 = darkmagic, returns 0
    @param str1 :   A C-string that possibly represents any word. 
    @param str2 :   Another C-string that possibly represents any word. 
    @return     :   Integer the first different index, returns length if equal.       */
int strDiffInd(char* str1, char* str2) {
    char* ptr1 = str1;
    char* ptr2 = str2;
    while (*ptr1 != '\0' && *ptr2 != '\0') {
        if (*ptr1 != *ptr2) return (ptr1 - str1);
        ptr1++;
        ptr2++;
    }
    if (*ptr1 != '\0' || *ptr2 != '\0') return (ptr1 - str1);
    return strlen(str1);
}

/** setSettings:                                                                      - -
    This functions modifies all the variables that is according to the user's command 
    line input. 
    @param argc         :   The length of argv[] array.
    @param argv         :   An array of C-strings that is the user's input. 
                            ["./main.out -optional"]
    @param wordSize     :   -n The length of the word to be guessed.
    @param numGuesse    :   -g The number of guesses the player gets before game 
                            terminates.
    @param statsMode    :   -s A print out mode that includes the statistics of 
                            possible words during the live gameplay.
    @param wordMode     :   -w A print out mode of all possible words before every
                            guess.
    @param letterMode   :   -l A print out mode that lists all previously guessed
                            letters before every guess.
    @param patternMode  :   -p A print out mode that lists all of the patterns in
                            the word list in detail including the subitems like
                            frequency, count, and the pattern string.
    @param verboseMode  :   -v A mode that turns on all of the print-out modes.
    @param extensionMode:   -e Not implemented mode.
    @return             :   Boolean representing successful settings, program 
                            terminates if not. | Modifies all mode variables.         */             
bool setSettings(int argc, char* argv[], int* wordSize, int* numGuesses, 
                 bool* statsMode, bool* wordMode, bool* letterMode, bool* patternMode, 
                 bool* verboseMode, bool* extensionMode) {
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-n") == 0) {
            if (atoi(argv[i + 1]) > 1) { 
                *wordSize = atoi(argv[i + 1]);
                i += 1;
            } else {
                printf("\nInvalid word size.\n");
                return false;
            }
        } else if (strcmp(argv[i], "-g") == 0) {
            if (atoi(argv[i + 1]) >= 1) { 
                *numGuesses = atoi(argv[i + 1]);
                i += 1;
            } else {
                printf("\nInvalid number of guesses.\n");
                return false;
            }
        } else if (strcmp(argv[i], "-s") == 0) {
            *statsMode = true;
        } else if (strcmp(argv[i], "-w") == 0) {
            *wordMode = true;
        } else if (strcmp(argv[i], "-l") == 0) {
            *letterMode = true;
        } else if (strcmp(argv[i], "-p") == 0) {
            *patternMode = true;
        } else if (strcmp(argv[i], "-v") == 0) {
            *statsMode = true; *wordMode = true; *letterMode = true; 
            *patternMode = true; 
        } else {
            printf("\nInvalid command-line argument.\n");
            return false;
        }
    }
    return true;
}

/** getGuessedLetter:                                                                 - -
    This function gets an input/letter from the user before every guess.
    @param guessedLetter:   The variable that stores the user's guess.
    @param usedLetters  :   A static array that represents all the previously guessed 
                            letters.
    @return             :   None | Modifies guessedLetter variable.                   */
bool getGuessedLetter(char* guessedLetter, bool usedLetters[]) {
    // Get an input from the user:
    // If input is CAPS: Invalid letter...
    // If input is already chosen: Letter previously guessed...
    // If input is #: Terminating game...
    while (true) {
        printf("Guess a letter (# to end game): ");
        scanf(" %c", guessedLetter);
        printf("\n");
        if (isupper(*guessedLetter) || !isalpha(*guessedLetter) && 
            *guessedLetter != '#') {
            printf("Invalid letter...\n"); 
            continue;
        } else if (*guessedLetter == '#') {
            printf("Terminating game...\n");
            return false;
        } else if (usedLetters[*guessedLetter - 'a']){ // Condition: Letter is already
                                                       // guessed.
            printf("Letter previously guessed...\n");
            continue;
        }
        break;
    }
    usedLetters[*guessedLetter - 'a'] = true;
    return true;
}

/** freePatternArray:                                                                 - -
    This function frees the heap memory of the entire pattern array including its
    contents.
    @param patternArray :   A dynamically heap-allocated array of patterns.
    @param numPatterns  :   The number of elements in the patternArray array.
    @return             :   None.                                                     */
void freePatternArray(Pattern* patternArray, int numPatterns) {
    for (int i = 0; i < numPatterns; i++) free(patternArray[i].pat);
    free(patternArray);
}

/** buildPatternArray:                                                                - -
    This function builds the pattern array by allocating memory from the heap. This
    function gets called after every guess as there is a unique pattern for every 
    guess.
    @param patternArray         :   A dynamically heap-allocated array of patterns.
    @param numPatterns          :   The number of elements in the patternArray array.
    @param patternArrayCapacity :   The capacity of the dynamically heap allocated 
                                    heap array.
    @param guessedLetter        :   The guessed letter of the player for that round.
    @param currentWord          :   The specific word to be analyzed to build the
                                    pattern array.
    @param wordSize             :   The size/length of currentWord.
    @param usedLetters          :   A static array that represents all the previously
                                    guessed letters.
    @param currentPattern       :   A c-string that represents the pattern. For 
                                    example, "----a-" or "patt_rn".
    @return                     :   None.                                             */
void buildPatternArray(Pattern** patternArray, int* numPatterns, 
                       int* patternArrayCapacity, char* guessedLetter, 
                       char* currentWord, int wordSize, bool usedLetters[], 
                       char* currentPattern) {
    if (*numPatterns == *patternArrayCapacity) {
        Pattern* newPatternArray = (Pattern*) malloc(sizeof(Pattern) * 
        (*patternArrayCapacity * 2));
        for (int i = 0; i < *numPatterns; i++) {
            newPatternArray[i] = (*patternArray)[i];
        }
        free(*patternArray);
        *patternArray = newPatternArray;
        *patternArrayCapacity *= 2;
    }
    char* pattern = (char*) malloc(sizeof(char) * (wordSize + 1));
    // Build pattern, for example "---a--"
    int changes = 0;
    for (int i = 0; i < wordSize; i++) {
        if (currentWord[i] == *guessedLetter) {
            pattern[i] = *guessedLetter;
            changes++;
        } else {
            pattern[i] = currentPattern[i];
        }
    }
    pattern[wordSize] = '\0';
    // Check if the pattern already exists in the patternArray, if so, store the index
    // of patternArray.
    int foundPatternInArray = -1;
    for (int i = 0; i < *numPatterns; i++) {
        if (strcmp((*patternArray)[i].pat, pattern) == 0) {
            foundPatternInArray = i;
        }
    }
    // Build the pattern array based on the retrieved info.
    if (foundPatternInArray == -1) {
        (*patternArray)[*numPatterns].pat = pattern;
        (*patternArray)[*numPatterns].changes = changes;
        (*patternArray)[*numPatterns].count = 1;
        *numPatterns += 1;
    } else {
        (*patternArray)[foundPatternInArray].count += 1;
        free(pattern);
    }
}

/** getNumWinners:                                                                    - -
    This is a helper function for the function analyzePatternArray. This returns the 
    number of 1's in candidates.
    @param candidates   :   A boolean array representing whether a candidate qualifes
                            or not.
    @param numPatterns  :   The number of elements in the patternArray array.
    @return             :   Integer representing the count of True in candidates.     */
int getNumWinners(bool candidates[], int numCandidates) {
    int ret = 0;
    for (int i = 0; i < numCandidates; i++) ret += candidates[i];
    return ret;
}

/** analyzePatternArray:                                                              - -
    The objective of this function is to judge the guess of the user and figure out
    whether the guessed letter appears in the answer or not.
    The main algorithm or the decision process: Given a list of possible patterns, we 
    can figure out the hardest pattern by going through different algorithms which are
    labeled in the code in detail.
    @param patternArray     :   A dynamically heap-allocated array of patterns.
    @param numPatterns      :   The number of elements in patternArray.
    @param guessedLetter    :   The guessed letter of the user.
    @param currentPattern   :   A c-string that represents the pattern. For 
                                example, "----a-" or "patt_rn".
    @return                 :   True: Correct guess | False: Wrong guess              */
bool analyzePatternArray(Pattern** patternArray, int* numPatterns, char guessedLetter, 
                         char* currentPattern) {

    int winnerIndex = -1, numCandidates = *numPatterns;
    bool candidates[numCandidates];
    
    // FIRST FILTER: We want the pattern/candidate that has the maximum "count" 
    // (i.e the pattern that appears the most in patternArray).
    int maximumCount = 0;
    for (int i = 0; i < numCandidates; i++) {
        if (maximumCount < (*patternArray)[i].count)
            maximumCount = (*patternArray)[i].count;
    }
    for (int i = 0; i < numCandidates; i++) 
        candidates[i] = maximumCount == (*patternArray)[i].count;
    
    // If there are more than one candidate, we need to filter more till we reach one.
    // SECOND FILTER: We want the pattern with the minimum "changes" (i.e the pattern 
    // that has the least changes).
    int leastChanges = 100000;
    if (getNumWinners(candidates, numCandidates) > 1) { 
        for (int i = 0; i < numCandidates; i++) {
            if (!candidates[i]) continue;
            if (leastChanges > (*patternArray)[i].changes) {
                leastChanges = (*patternArray)[i].changes;
            }
        }
        for (int i = 0; i < numCandidates; i++) {
            if (leastChanges != (*patternArray)[i].changes) {
                candidates[i] = false;
            }
        }
    }

    // If there are more than one candidate, we need to filter more till we reach one.
    // THIRD FILTER: Find whose guessed letter appears the closest: Keep incrementing 
    // cur until a single pattern is chosen.  
    int cur = 0;
    while (getNumWinners(candidates, numCandidates) > 1) {
        int temp = 0;
        for (int i = 0; i < numCandidates; i++) {
            if (!candidates[i]) continue;
            if (guessedLetter == (*patternArray)[i].pat[cur]) 
                temp++;
        }
        if (temp < 1) {
            cur++;
            continue;
        } 
        for (int i = 0; i < numCandidates; i++) {
            if (!candidates[i]) continue;
            if (guessedLetter != (*patternArray)[i].pat[cur]) 
                candidates[i] = false;
        }
        cur++;
    }

    // Build the new current pattern.
    char newCurrentPattern[strlen(currentPattern) + 1];
    for (int i = 0; i < numCandidates; i++) {
        if (candidates[i]) {
            for (int j = 0; (*patternArray)[i].pat[j] != '\0'; j++) {
                if ((*patternArray)[i].pat[j] == guessedLetter) {
                    newCurrentPattern[j] = guessedLetter;
                } else {
                    newCurrentPattern[j] = currentPattern[j];
                }
            }
            break;
        }
    }
    newCurrentPattern[strlen(currentPattern)] = '\0';
    // return True if good guess, return False if bad guess. 
    // strcmp() returns 0 if they're the same or bad guess.
    // strcmp() returns (not 0) 
    bool ret = (strcmp(newCurrentPattern, currentPattern) == 0) ? false : true;
    strcpy(currentPattern, newCurrentPattern);

    return ret;
}

/** freeWordList:                                                                     - -
    This function frees the heap memory of the entire words array including its
    contents.
    @param words    :   The dynamic heap-allocated array containing words (C-strings).
    @param numWords :   The number of elements in the words array.
    @returns        :   None.                                                         */
void freeWordList(char*** words, int* numWords) {
    for (int i = 0; i < *numWords; i++) free((*words)[i]);
    free(*words);
}

/** recreateWordList:                                                                 - -
    This function recreates the words arrays because as the game goes on, the list of 
    possible words decreases. Possible in the sense that word is still in our pool of 
    choice as we basically want to deceive the player. For example:
    Given currentPattern = "_ed", possible words are "bed" and "red".
    @param words            :   The dynamic heap-allocated array containing words 
                                (C-strings).
    @param numWords         :   The number of strings in the words array.
    @param numCapacity      :   The capacity of the words array.
    @param guessedLetter    :   The guessed letter of the user.
    @return                 :   None | Modifies words through re-allocation, numWords, 
                                and numCapacity.                                      */
void recreateWordList(char*** words, int* numWords, int* numCapacity, 
                      char guessedLetter, char* currentPattern) {
    int capacity = 4, numNewWords = 0, numOfLetters = 0;
    char** newWordList = (char**) malloc(capacity*sizeof(char*));
    for (int i = 0; i < strlen(currentPattern); i++) {
        if (currentPattern[i] != '-') numOfLetters++;
    }

    for (int i = 0; i < *numWords; i++) {
        bool valid = true;
        // guessed letter: o
        // current word: open
        // pattern: o---
        // this loop traverses all the words and checks if the word is still valid or 
        // not.
        // valid: still guessable 
        // remove all instances of o, if you don't see "o" in the current pattern.
        // if there is another instance of o:
        //      if you found o and it is not seen in the pattern.
        // invalid: non-guessable
        int found = 0;
        for (int j = 0; (*words)[i][j] != '\0'; j++) {
            if (currentPattern[j] == guessedLetter) {
                found++;
            }
        }
        if (!found) { // if current pattern has no o, then remove all words with o in 
                      // it.
            for (int j = 0; (*words)[i][j] != '\0'; j++) {
                if ((*words)[i][j] == guessedLetter) {
                    valid = false;
                    break;
                }
            }
        } else { // if current pattern has o's, remove words that has different 
                 // number of o's, or different locations.
            int temp = 0;
            for (int j = 0; (*words)[i][j] != '\0'; j++) {
                if ((*words)[i][j] == guessedLetter) {
                    temp++;
                    if (currentPattern[j] != guessedLetter) {
                    valid = false;
                    break;
                    }
                }
            }    
            if (temp != found) valid = false;     
        }
        if (valid) {
            addWord(&newWordList, &numNewWords, &capacity, (*words)[i]);
        }
        
    }   
    // Free the entire wordsList
    freeWordList(words, numWords);
    // Rewire the wordList to newWordList
    *words = newWordList;
    *numWords = numNewWords;
    *numCapacity = capacity;
}

/** printWords:                                                                       - -
    This function prints all the words in the array.
    @param wordList :   The dynamic heap-allocated array containing words 
                        (C-strings).
    @param numWords :   The number of strings in the words array.
    @param wordSize :   The size of the word in the words array.
    @return         :   None.                                                         */
bool printWords(char** wordList, int numWords, int wordSize) {
    for (int i = 0; i < numWords; i++) printf("  %s", wordList[i]);
    if (!numWords) {
        printf("Dictionary has no words of length %d.\nTerminating program...", 
                wordSize);
        return false;
    }
    return true;
}

/** printLetters:                                                                     - -
    This function prints the previously guessed letters.
    @param usedLetters  :   A static array that represents all the previously guessed 
                            letters.
    @return             :   None.                                                     */
void printLetters(bool usedLetters[]) {
    printf("Previously guessed letters: ");
    for (int i = 0; i < 26; i++) {
        if (usedLetters[i]) printf("%c ", i + 'a');
    }
    printf("\n");
}

/** printsettings:                                                                    - -
    This function prints the state of every setting.
    @param wordSize     :   -n The length of the word to be guessed.
    @param numGuesses   :   -g The number of guesses the player gets before game 
                            terminates.
    @param statsMode    :   -s A print out mode that includes the statistics of 
                            possible words during the live gameplay.
    @param wordMode     :   -w A print out mode of all possible words before every
                            guess.
    @param letterMode   :   -l A print out mode that lists all previously guessed
                            letters before every guess.
    @param patternMode  :   -p A print out mode that lists all of the patterns in
                            the word list in detail including the subitems like
                            frequency, count, and the pattern string.
    @return             :   None.                                                     */    
void printSettings(int* wordSize, int* numGuesses, bool* statsMode, bool* wordMode, 
                   bool* letterMode, bool* patternMode) {
    printf("Game Settings:\n");
    printf("  Word Size = %d\n", *wordSize);
    printf("  Number of Guesses = %d\n", *numGuesses);
    printf("  View Stats Mode = %s\n", (*statsMode) ? "ON" : "OFF");
    printf("  View Word List Mode = %s\n", (*wordMode) ? "ON" : "OFF");
    printf("  View Letter List Mode = %s\n", (*letterMode) ? "ON" : "OFF");
    printf("  View Pattern List Mode = %s\n", (*patternMode) ? "ON" : "OFF");
}

/** printPatternArray:                                                                - -
    This function prints the array of patterns including its subitems such as 
    frequency, count and pattern string.
    @param patternArray :   A dynamically heap-allocated array of patterns.
    @param numPatterns  :   The number of elements in patternArray.
    @param guessedLetter:   The guessed letter.
    @return             :   None.                                                     */    
void printPatternArray(Pattern** patternArray, int* numPatterns, char guessedLetter) {
    printf("All patterns for letter %c: \n", guessedLetter); 
    for (int i = 0; i < *numPatterns; i++) {
        printf("  %s \tcount = %d \tchanges = %d\n", (*patternArray)[i].pat, 
               (*patternArray)[i].count, (*patternArray)[i].changes);
    }
}

/** main:                                                                             - -
    The driver code of the program. This is where the code starts.
    @return     : integer to signify successful program execution.                    */
int main(int argc, char* argv[]) {

    printf("Welcome to the (Evil) Word Guessing Game!\n\n");

    // General variables:
    int wordSize = 5, numGuesses = 26, capacity = 4, numWords = 0, dictionarySize = 0;
    bool solved = false;
    char longestWord[100] = "", buffer[100];
    char** wordList = (char**) malloc(capacity*sizeof(char*)); 
    // Settings variables:
    bool statsMode = false, wordMode = false, letterMode = false, patternMode = false;
    bool verboseMode = false, extensionMode = false;
    
    if (setSettings(argc, argv, &wordSize, &numGuesses, &statsMode, &wordMode, 
                    &letterMode, &patternMode, &verboseMode, &extensionMode)) {
        printSettings(&wordSize, &numGuesses, &statsMode, &wordMode, &letterMode, 
                      &patternMode);
    } else {
        printf("Terminating program...\n");
        return 0;
    }

    // File processing:
    FILE* inputFile;
    inputFile = fopen("dictionary.txt", "r");
    while (fgets(buffer, 100, inputFile)) {
        dictionarySize++;
        // Don't include \n
        for (int i = 0; buffer[i] != '\0'; i++) {
            if (buffer[i] == '\n') {
                buffer[i] = '\0';
                break;
            }
        }
        // Get the longest word:
        if (strlen(buffer) > strlen(longestWord)) {
            strcpy(longestWord, buffer);
            longestWord[strlen(buffer)] = '\0';
        }
        // Add the word to the array if it is equal to the given size.
        if (strlen(buffer) == wordSize) 
            addWord(&wordList, &numWords, &capacity, buffer);
    }
    fclose(inputFile);

    if (statsMode) {
        printf("The dictionary contains %d words total.\n"
                "The longest word %s has %ld chars.\n"
                "The dictionary contains %d words of length %d.\n"
                "Max size of the dynamic words array is %d.\n", 
                dictionarySize, longestWord, (long) strlen(longestWord), numWords, 
                wordSize, capacity);
    } 
    
    if (wordMode) {
        printf("Words of length %d:\n", wordSize);
        if (!printWords(wordList, numWords, wordSize)) return 0;
    }

    // currentPattern and usedLetter initialization:
    char currentPattern[wordSize + 1]; 
    bool usedLetters[26]; 
    for (int i = 0; i < wordSize; i++) currentPattern[i] = '-';
    currentPattern[wordSize] = '\0';
    for (int i = 0; i < 26; i++) usedLetters[i] = false;
    
    // Main game loop:
    printf("The word pattern is: %s\n\n", currentPattern);
    while (numGuesses && !solved) {
        char guessedLetter; 
        
        printf("Number of guesses remaining: %d\n", numGuesses);
        if (letterMode)
            printLetters(usedLetters);
        if (!getGuessedLetter(&guessedLetter, usedLetters)) return 0;

        // Build a dynamic array of unique pattern structs (capacity of 4 initially, 
        // doubles when exceeds)
        int numPatterns = 0, patternArrayCapacity = 4;
        Pattern* patternArray = (Pattern*) malloc(patternArrayCapacity * 
                                sizeof(Pattern));
        for (int i = 0; i < numWords; i++) {  // Pattern is built off numwWords and 
                                              // wordList;
            buildPatternArray(&patternArray, &numPatterns, &patternArrayCapacity,  
                              &guessedLetter, wordList[i], wordSize, usedLetters, 
                              currentPattern);
        } 
        if (patternMode)
            printPatternArray(&patternArray, &numPatterns, guessedLetter);

        // Analyze the array of pattern structs: (the idea is to be evil and make the
        // game hardest for the player). This changes the currentPattern variable.
        if (analyzePatternArray(&patternArray, &numPatterns, guessedLetter, 
            currentPattern)) {
            printf("Good guess! The word has at least one %c.\n", guessedLetter);
        } else {
            printf("Oops, there are no %c's. You used a guess.\n", guessedLetter);
            numGuesses--;
        }

        // Recreate wordList: changes wordList.
        recreateWordList(&wordList, &numWords, &capacity, guessedLetter, 
                         currentPattern);

        if (statsMode)
            printf("Number of possible words remaining: %d\n", numWords);
        if (wordMode) {
            printf("Possible words are now:\n");
            if (!printWords(wordList, numWords, wordSize)) return 0;
        }
        
        printf("The word pattern is: %s\n\n", currentPattern);

        solved = true;
        for (int i = 0; i < strlen(currentPattern); i++) {
            if (currentPattern[i] == '-') solved = false;
        }
        freePatternArray(patternArray, numPatterns); 
    }
    if (solved) {
        printf("You solved the word!\nThe word is: %s\nGame over.", currentPattern);
    } else {
        printf("You ran out of guesses and did not solve the word.\nThe word is: %s\n"
               "Game over.", wordList[0]);
    }
    
    freeWordList(&wordList, &numWords);
    return 0;
}
