#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

typedef struct Pattern_struct {
    char* pat;  //string pattern - exs: "hello", "-ell-", "-----"
    int count;  //frequency of pattern in the current word list
    int changes;//number of occurences of new letter in this pattern
} Pattern;


//-------------------------------------------------------------------
// TODO - Task II: write addWord() function, which adds a new word to
//      a dynamic heap-allocated array of C-strings; heap-space must  
//      be allocated for the new word inside this function, then copy  
//      the chars from newWord to the newly allocated heap-space; if
//      adding the new word pushes numWords above maxWords, then 
//      realloate the words array with double the capacity
//      parameters: 
//          char*** words - array of C-strings passed-by-pointer
//              note: *words is an array of pointers
//                    **words is an array of chars
//                    ***words is a char  
//                    (*words)[0] is the 1st C-string in the array
//                    (*words)[1] is the 2nd C-string in the array
//                    (*words)[0][0] is 1st char of 1st C-string
//                    (*words)[1][2] is 3rd char of 2nd C-string
//                    etc.
//          int* numWords - current # of words in *words array
//               note: numWords will increase by 1 here, 
//                     so it is passed-by-pointer
//          int* maxWords - current capacity of *words array
//               note: maxWords may increase by x2 here, 
//                     so it is passed-by-pointer
//          char* newWord - C-string word to be added to words
//               note: newWord is a C-string, automatically a pointer
//-------------------------------------------------------------------
void addWord(char*** words, int* numWords, int* maxWords, char* newWord) {
    if (*numWords == *maxWords) { // Case: the current words exceed the capacity, double the size of **words.
        char** newArray = (char**) malloc(sizeof(char*) * (*maxWords * 2));
        for (int i = 0; i < *numWords; i++) {
            newArray[i] = (*words)[i];
        } 
        free(*words);
        *words = newArray;
        *maxWords *= 2;
    }

    char* newWordCopy = (char*) malloc(sizeof(char) * (strlen(newWord) + 1)); // Add + 1 because of the edge case '\0'
    strcpy(newWordCopy, newWord);

    // Add the new word to the end of the array and update *numWords;
    (*words)[*numWords] = newWordCopy;
    // free(newWordCopy);
    *numWords += 1;
}


//-------------------------------------------------------------------
// TODO - Task V: write the strNumMods() function, which
//      returns count of character differences between two strings;
//      includes extra characters in longer string if different lengths
// Exs: str1 = magic, str2 = magic, returns 0
//      str1 = wands, str2 = wants, returns 1
//      str1 = magic, str2 = wands, returns 4
//      str1 = magic, str2 = mag, returns 2
//      str1 = magic, str2 = magicwand, returns 4
//      str1 = magic, str2 = darkmagic, returns 8
//-------------------------------------------------------------------
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


//-------------------------------------------------------------------
// TODO - Task VI: write the strDiffInd() function, which
//      returns index of the character where two strings first differ, &
//      returns strlen(str1) = strlen(str2) if no differences
// Exs: str1 = magic, str2 = magic, returns 5
//      str1 = wands, str2 = wants, returns 3
//      str1 = magic, str2 = wands, returns 0
//      str1 = magic, str2 = mag, returns 3
//      str1 = magic, str2 = magicwand, returns 5
//      str1 = magic, str2 = darkmagic, returns 0
//-------------------------------------------------------------------
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


bool setSettings(int argc, char* argv[], int* wordSize, int* numGuesses, bool* statsMode, bool* wordMode, bool* letterMode, bool* patternMode, bool* verboseMode, bool* extensionMode) {
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
            *statsMode = true; *wordMode = true; *letterMode = true; *patternMode = true; 
        } else {
            printf("\nInvalid command-line argument.\n");
            return false;
        }
    }
    return true;
}




bool getGuessedLetter(char* guessedLetter, bool usedLetters[]) {
    // Get an input from the user:
    // If input is CAPS: Invalid letter...
    // If input is already chosen: Letter previously guessed...
    // If input is #: Terminating game...
    while (true) {
        printf("Guess a letter (# to end game): ");
        scanf(" %c", guessedLetter);
        printf("\n");
        if (isupper(*guessedLetter) || !isalpha(*guessedLetter) && *guessedLetter != '#') {
            printf("Invalid letter...\n"); 
            continue;
        } else if (*guessedLetter == '#') {
            printf("Terminating game...\n");
            return false;
        } else if (usedLetters[*guessedLetter - 'a']){ // Condition: Letter is already guessed
            printf("Letter previously guessed...\n");
            continue;
        }
        break;
    }
    usedLetters[*guessedLetter - 'a'] = true;
    return true;
}


void freePatternArray(Pattern* patternArray, int numPatterns) {
    for (int i = 0; i < numPatterns; i++) {
        free(patternArray[i].pat);
    }
    free(patternArray);
}

// buildPatternArray(&patternArray, &numPatterns, &patternArrayCapacity, &guessedLetter, wordList[i], wordSize, usedLetters);
void buildPatternArray(Pattern** patternArray, int* numPatterns, int* patternArrayCapacity, char* guessedLetter, char* currentWord, int wordSize, bool usedLetters[], char* currentPattern) {
    if (*numPatterns == *patternArrayCapacity) {
        Pattern* newPatternArray = (Pattern*) malloc(sizeof(Pattern) * (*patternArrayCapacity * 2));
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

    // Check if the pattern already exists in the patternArray, if so, store the index of patternArray.
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


int getNumWinners(bool candidates[], int numCandidates) {
    int ret = 0;
    for (int i = 0; i < numCandidates; i++) {
        ret += candidates[i];
    }
    return ret;
}


bool analyzePatternArray(Pattern** patternArray, int* numPatterns, char guessedLetter, char* currentPattern) {

    int winnerIndex = -1, numCandidates = *numPatterns;
    bool candidates[numCandidates];
    
    // FIRST FILTER: We want the pattern/candidate that has the maximum "count" (i.e the pattern that appears the most in patternArray).
    int maximumCount = 0;
    for (int i = 0; i < numCandidates; i++) {
        if (maximumCount < (*patternArray)[i].count)
            maximumCount = (*patternArray)[i].count;
    }
    for (int i = 0; i < numCandidates; i++) {
        candidates[i] = false;
        if (maximumCount == (*patternArray)[i].count) {
            candidates[i] = true;
        }
    }
    
    // If there are more than one candidate, we need to filter more till we reach one.
    // SECOND FILTER: We want the pattern with the minimum "changes" (i.e the pattern that has the least changes).
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
    // THIRD FILTER: Find whose guessed letter appears the closest:
    // Keep incrementing cur until a single pattern is chosen.  
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
    // returj True if good guess, return False if bad guess. 
    // strcmp() returns 0 if they're the same or bad guess.
    // strcmp() returns (not 0) 
    bool ret = (strcmp(newCurrentPattern, currentPattern) == 0) ? false : true;
    strcpy(currentPattern, newCurrentPattern);

    return ret;
}


void freeWordList(char*** words, int* numWords) {
    for (int i = 0; i < *numWords; i++) {
        free((*words)[i]);
    }
    free(*words);
}


void recreateWordList(char*** words, int* numWords, int* numCapacity, char guessedLetter, char* currentPattern) {
    int capacity = 4, numNewWords = 0;
    char** newWordList = (char**) malloc(capacity*sizeof(char*));
    int numOfLetters = 0;
    for (int i = 0; i < strlen(currentPattern); i++) {
        if (currentPattern[i] != '-') numOfLetters++;
    }

    for (int i = 0; i < *numWords; i++) {
        bool valid = true;
        // Find if the guessed letter is in word, then don't add that.
        // magic, ----- = 5, numOfLetters = 0
        // magic, -a--- = 4, numOfLetters = 1, magic
        // if (strNumMods((*words)[i], currentPattern) == numOfLetters) {
        //     valid = false;
        // }

        // guessed letter: o
        // current word: open
        // pattern: o---
        // this loop traverses all the words and checks if the word is still valid or not
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


        if (!found) { // if current pattern has no o, then remove all words with o in it.
            for (int j = 0; (*words)[i][j] != '\0'; j++) {
                if ((*words)[i][j] == guessedLetter) {
                    valid = false;
                    break;
                }
            }
        } else { // if current pattern has o's, remove words that has different number of o's, or different locations.
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

bool printWords(char** wordList, int numWords, int wordSize) {
    for (int i = 0; i < numWords; i++) {
        printf("  %s", wordList[i]);
    }
    if (!numWords) {
        printf("Dictionary has no words of length %d.\nTerminating program...", wordSize);
        return false;
    }
    return true;
}

void printLetters(bool usedLetters[]) {
    printf("Previously guessed letters: ");
    for (int i = 0; i < 26; i++) {
        if (usedLetters[i]) {
            printf("%c ", i + 'a');
        }
    }
    printf("\n");
}

void printSettings(int* wordSize, int* numGuesses, bool* statsMode, bool* wordMode, bool* letterMode, bool* patternMode) {
    printf("Game Settings:\n");
    printf("  Word Size = %d\n", *wordSize);
    printf("  Number of Guesses = %d\n", *numGuesses);
    printf("  View Stats Mode = %s\n", (*statsMode) ? "ON" : "OFF");
    printf("  View Word List Mode = %s\n", (*wordMode) ? "ON" : "OFF");
    printf("  View Letter List Mode = %s\n", (*letterMode) ? "ON" : "OFF");
    printf("  View Pattern List Mode = %s\n", (*patternMode) ? "ON" : "OFF");
}

void printPatternArray(Pattern** patternArray, int* numPatterns, char guessedLetter) {
    printf("All patterns for letter %c: \n", guessedLetter); 
    for (int i = 0; i < *numPatterns; i++) {
        printf("  %s \tcount = %d \tchanges = %d\n", (*patternArray)[i].pat, (*patternArray)[i].count, (*patternArray)[i].changes);
    }
}


int main(int argc, char* argv[]) {

    printf("Welcome to the (Evil) Word Guessing Game!\n\n");
    
    bool solved = false;
    
    //-------------------------------------------------------------------
    // TODO - Task I: handle command-line arguments
    // command-line arguments:
    //  [-n wordSize] = sets number of characters in word to be guessed;
    //                  if dictionary has no words of length wordSize,
    //                  then print:
    //                    "Dictionary has no words of length [wordSize]."
    //                    "Terminating program..."
    //                  default wordSize = 5
    // [-g numGuesses] = sets number of unsuccessful letter guesses;
    //                   numGuesses must be a positive integer,
    //                   otherwise print 
    //                     "Invalid number of guesses."
    //                     "Terminating program..."
    //                   default numGuesses = 26 
    //                   (note: 26 guesses guarantees player can win)
    // [-s] = stats mode, which includes printing of dictionary 
    //                    statistics AND number of possible words 
    //                    remaining during gameplay.
    //                    default is OFF
    // [-w] = word list mode, which includes a print out of the full 
    //                        list of possible words before every guess.
    //                        default is OFF
    // [-l] = letter list mode, which prints out a list of previously 
    //                          guessed letters before each new guess
    //                          default is OFF
    // [-p] = pattern list mode, which prints out a list of all patterns 
    //                           in the word list, together with the
    //                           frequency of each pattern and the 
    //                           number of changes in the pattern due to
    //                           the current guess
    //                           default is OFF
    // [-v] = verbose mode, which turns ON stats mode, word list mode, 
    //                      letter list mode, AND pattern list mode
    // [-x] = extension mode, which is an optional extra credit 
    //                        extension doing something interesting with
    //                        the evil word game, e.g. optimizing the 
    //                        algorithm to predict future guesses
    //-------------------------------------------------------------------
    int wordSize = 5, numGuesses = 26;
    bool statsMode = false, wordMode = false, letterMode = false, patternMode = false, verboseMode = false, extensionMode = false;
    if (setSettings(argc, argv, &wordSize, &numGuesses, &statsMode, &wordMode, &letterMode, &patternMode, &verboseMode, &extensionMode)) {
        printSettings(&wordSize, &numGuesses, &statsMode, &wordMode, &letterMode, &patternMode);
    } else {
        printf("Terminating program...\n");
        return 0;
    }

    //-------------------------------------------------------------------
    // TODO - Task III: file-read the word list from dictionary.txt, 
    //                  storing only words of length set by wordSize 
    //                  (a command-line argument) in a dynamically
    //                  growing heap-allocated array of C-strings:
    //                      - the word list should be a dynamic array of 
    //                        pointers, initially with maximum size 4, 
    //                        doubling in maximum size whenever more 
    //                        space is needed
    //                      - each element of the word list array should 
    //                        point to a heap-allocated C-string that 
    //                        can store a word containing exactly 
    //                        wordSize lower-case letters
    //-------------------------------------------------------------------
    int capacity = 4, numWords = 0, dictionarySize = 0;
    char** wordList = (char**) malloc(capacity*sizeof(char*)); // FIRST MALLOC DONE.
    char longestWord[100] = "", buffer[100];
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

    //-------------------------------------------------------------------
    // TODO - Task IV: display dictionary stats [-s] & word list [-w] 
    //                 if the proper command-line flags are turned ON;
    //                 see sample output for proper formatting 
    //-------------------------------------------------------------------
    if (statsMode) {
        printf("The dictionary contains %d words total.\n"
                "The longest word %s has %ld chars.\n"
                "The dictionary contains %d words of length %d.\n"
                "Max size of the dynamic words array is %d.\n", 
                dictionarySize, longestWord, (long) strlen(longestWord), numWords, wordSize, capacity);
    } 
    
    if (wordMode) {
        printf("Words of length %d:\n", wordSize);
        if (!printWords(wordList, numWords, wordSize)) return 0;
    }


    //-------------------------------------------------------------------
    // TODO - Task VII: play the game; repeatedly...
    //           - Input a character from user as their guess; 
    //             if guess is not a lower case letter OR has been 
    //             previously guessed, input another character.
    //           - Build a dynamic array of unique Pattern structs, 
    //             where each Pattern contains a heap-allocated C-string
    //             representing the current status of the final word, 
    //             with a '-' for each unsettled character; for each word
    //             in the current word list, produce an updated pattern  
    //             by replacing '-'s with current letter guess wherever 
    //             that letter appears in the word, and either appending 
    //             it as a new Pattern if it is unique in the array of 
    //             Patterns, OR incrementing the count subitem for the
    //             appropriate Pattern. The array of Patterns should 
    //             dynamically grow, beginning with maximum size 4, 
    //             doubling whenever more space is needed.
    //           - Find the most common pattern in the current word list 
    //             and update the final word pattern;
    //             i.e. find the Pattern in the array that has the 
    //             highest count subitem. Break ties as follows: 
    //                + for two Patterns with the same count, select the 
    //                  one with fewer occurences of the guessed letter;
    //                  i.e. smaller changes subitem
    //                + for two Patterns with the same count & changes,
    //                  select the one where the fist occurrence of the 
    //                  guessed letter is earlier in the word
    //           - Report to the user whether their guessed letter is in 
    //             the final word or not. End the game if the user has 
    //             used all of the allowed guesses or has solved the 
    //             final word. Otherwise, repeat the process by inputting 
    //             another letter from the user.
    //           - Throughout the game, produce print statements matching 
    //             the format of the sample outputs; only printing the 
    //             statistics [-s], word list [-w], letter list [-l], and 
    //             pattern list [-p] if the proper command-line flags are 
    //             turned ON;
    //-------------------------------------------------------------------
    


    // Once the final pattern has been analyzed, check whether the player guessed right or wrong:
        // If their guessed letter is not in the pattern, then they are WRONG -> lost one of their lives.
        // If right: repeat the process.

    char currentPattern[wordSize + 1]; // starts with "---------"
    bool usedLetters[26]; // tracks all used alphabets
    for (int i = 0; i < wordSize; i++) {
        currentPattern[i] = '-';
    } 
    currentPattern[wordSize] = '\0';
    for (int i = 0; i < 26; i++) {
        usedLetters[i] = false;
    }

    printf("The word pattern is: %s\n\n", currentPattern);
    while (numGuesses && !solved) {
        char guessedLetter; 
        
        printf("Number of guesses remaining: %d\n", numGuesses);
        if (letterMode)
            printLetters(usedLetters);
        if (!getGuessedLetter(&guessedLetter, usedLetters)) return 0;

        // Build a dynamic array of unique pattern structs (capacity of 4 initially, doubles when exceeds)
        int numPatterns = 0, patternArrayCapacity = 4;
        Pattern* patternArray = (Pattern*) malloc(patternArrayCapacity * sizeof(Pattern));
        for (int i = 0; i < numWords; i++) {  // Pattern is built off numwWords and wordList;
            buildPatternArray(&patternArray, &numPatterns, &patternArrayCapacity, &guessedLetter, wordList[i], wordSize, usedLetters, currentPattern);
        } 
        if (patternMode)
            printPatternArray(&patternArray, &numPatterns, guessedLetter);

        // Analyze the array of pattern structs: (the idea is to be evil and make the game hardest for the player)
        // This changes the currentPattern variable.
        if (analyzePatternArray(&patternArray, &numPatterns, guessedLetter, currentPattern)) {
            printf("Good guess! The word has at least one %c.\n", guessedLetter);
        } else {
            printf("Oops, there are no %c's. You used a guess.\n", guessedLetter);
            numGuesses--;
        }

        // Recreate wordList: changes wordList.
        recreateWordList(&wordList, &numWords, &capacity, guessedLetter, currentPattern);

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
        printf("You ran out of guesses and did not solve the word.\nThe word is: %s\nGame over.", wordList[0]);
    }
    
    //-------------------------------------------------------------------
    // TODO - Task VIII:free all heap-allocated memory to avoid potential 
    //                  memory leaks. Since the word size for each game 
    //                  play is a command-line argument, any array whose 
    //                  size depends on the word size should be 
    //                  dynamically heap-allocated, and thus must be 
    //                  tracked and freed
    //-------------------------------------------------------------------

    freeWordList(&wordList, &numWords);
    return 0;
}
