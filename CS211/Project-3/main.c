#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

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
    
    return -1; //modify this
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
    
    return -1; //modify this
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
            if (atoi(argv[i + 1]) > 1) { 
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

void printSettings(int* wordSize, int* numGuesses, bool* statsMode, bool* wordMode, bool* letterMode, bool* patternMode) {
    printf("Game Settings:\n");
    printf("  Word Size = %d\n", *wordSize);
    printf("  Number of Guesses = %d\n", *numGuesses);
    printf("  View Stats Mode = %s\n", (*statsMode) ? "ON" : "OFF");
    printf("  View Word List Mode = %s\n", (*wordMode) ? "ON" : "OFF");
    printf("  View Letter List Mode = %s\n", (*letterMode) ? "ON" : "OFF");
    printf("  View Pattern List Mode = %s\n", (*patternMode) ? "ON" : "OFF");
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
    char** wordList = (char**) malloc(capacity*sizeof(char*));
    char longestWord[100] = "", buffer[100];
    FILE* inputFile;
    inputFile = fopen("dictionary.txt", "r");
    while (fgets(buffer, 100, inputFile)) {
        dictionarySize++;
        // Get the longest word:
        if (strlen(buffer) > strlen(longestWord)) {
            strcpy(longestWord, buffer);
        }
        // Add the word to the array if it is equal to the given size.
        if ((strlen(buffer) - 1) == wordSize) 
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
                dictionarySize, longestWord, strlen(longestWord) - 1, numWords, wordSize, capacity);
    } 
    if (wordMode) {
        printf("Words of length %d:\n", wordSize);
        for (int i = 0; i < numWords; i++) {
            printf("  %s", wordList[i]);
        }
        if (!numWords) {
            printf("Dictionary has no words of length %d.\nTerminating program...", wordSize);
            return 0;
        }
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
    

    
    //-------------------------------------------------------------------
    // TODO - Task VIII:free all heap-allocated memory to avoid potential 
    //                  memory leaks. Since the word size for each game 
    //                  play is a command-line argument, any array whose 
    //                  size depends on the word size should be 
    //                  dynamically heap-allocated, and thus must be 
    //                  tracked and freed
    //-------------------------------------------------------------------
    

    
    return 0;
}
