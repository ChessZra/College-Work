/* -----------------------------------------------------------------------------------
Program 5: Find the Shortest Word Ladder
Course: CS 211, Fall 2023, UIC
System: Advanced zyLab
Author: ChessZra
- -               - -
Description: A word ladder is a sequence of words where each word is formed from the 
previous one by changing just one letter, while ensuring that each intermediate word 
is a valid word. This program generates and explores such word ladders, finding a path
from one given word to another by making incremental changes in the letters, ensuring
that each intermediate word is a valid word.
------------------------------------------------------------------------------------- */
// Preproccesor directives:
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>

typedef struct WordNode_struct {
    char* myWord;
    struct WordNode_struct* next; 
} WordNode;

typedef struct LadderNode_struct {
    WordNode* topWord;
    struct LadderNode_struct* next; 
} LadderNode;

/** countWordsOfLength:                                                               - -
    Given an input file filled with words, this function counts the number of 
    occurences of word that are exactly wordSize long.
    @param filename :   The input file name in C-string.
    @param wordSize :   The given word size.
    @return         :   -1 if invalid filename, otherwise, the number (INT) of words 
                        found.                                                        */
int countWordsOfLength(char* filename, int wordSize) { 
    int ret = 0;
    FILE* inputFile = fopen(filename, "r");

    if (inputFile == NULL) return -1;

    char buffer[1024];
    while(fgets(buffer, 1024, inputFile)) {
        int curWordLength = 0;
        for (int i = 0; buffer[i] != '\0' && buffer[i] != '\n'; i++) curWordLength++;
        if (curWordLength == wordSize) ret++;
    }

    fclose(inputFile);

    return ret;
}

/** buildWordArray:                                                                   - -
    This function builds the pre-allocated words array by filling the array with words 
    of a specific size.
    @param filename :   The input file name in C-string.
    @param words    :   A dynamically heap-allocated array of C-strings.
    @param numWords :   The number of words to be initialized inside words.
    @param wordSize :   The size of individual words in words.
    @return         :   True if successful execution, 
                        False if valid filename or numWords does not match provided 
                        file.                                                         */
bool buildWordArray(char* filename, char** words, int numWords, int wordSize) { 
    // Base Case: Return F if invalid file name OR the file does not have numWords.
    int wordSizeChecker = countWordsOfLength(filename, wordSize);
    if (wordSizeChecker < 0 || wordSizeChecker != numWords) return false;
    
    FILE* inputFile = fopen(filename, "r");
    char buffer[1024];
    int idx = 0;

    while(fgets(buffer, 1024, inputFile)) {
        int curWordLength = 0;
        for (int i = 0; buffer[i] != '\0' && buffer[i] != '\n'; i++) curWordLength++;
        buffer[curWordLength] = '\0';
        if (curWordLength == wordSize) {
            strcpy(words[idx++], buffer);
        }
        
    }
    fclose(inputFile);
    return true;
}

/** findWord:                                                                         - -
    This function finds the index of where aWord is located in the words array. This
    function utilizes the binary-search algorithm. 
    @param words    :   A dynamically heap-allocated array of C-strings.
    @param aWord    :   The word to be searched.
    @param loInd    :   An integer representing the first index of words.
    @param hiInd    :   An integer representing the last index of words.
    @return         :   -1 if not found, otherwise return the index                   */
int findWord(char** words, char* aWord, int loInd, int hiInd) { 
    while (loInd <= hiInd) {
        // The midpoint formula is the same as (low + high) / 2, but this handles
        // edge cases properly.
        int midInd = loInd + (hiInd - loInd) / 2;
        int compare = strcmp(aWord, words[midInd]);
        if (compare == 0) {
            return midInd;
        } else if (compare > 0) {
            loInd++;
        } else {
            hiInd--;
        }
    }
    return -1;
}

/** freeWords:                                                                        - -
    This function frees the words array from the heap.
    @param words    :   A dynamically heap-allocated array of C-strings.
    @param numWords :   The number of strings inside words.
    @return         :   None                                                          */
void freeWords(char** words, int numWords) {
    for (int i = 0; i < numWords; i++) free(words[i]);
    free(words);
}

/** insertWordAtFront:                                                                - -
    This function expands the given linked list and inserts a new node to the front.
    @param ladder   :   A pointer to the head of the ladder (linked list).
    @param newWord  :   The C-string that is to be inserted to the ladder.
    @return         :   None                                                          */
void insertWordAtFront(WordNode** ladder, char* newWord) {
    WordNode* newWordNode = (WordNode*) malloc(sizeof(WordNode)); 
    newWordNode->myWord = newWord;
    newWordNode->next = (*ladder);
    *ladder = newWordNode;
}

/** getLadderHeight:                                                                  - -
    This function returns the height of the ladder.
    @param ladder   :   The "head"/top of the ladder.
    @return         :   An integer representing the height of the ladder.             */
int getLadderHeight(WordNode* ladder) {
    int height = 0;
    while (ladder != NULL) {
        height++;
        ladder = ladder->next;
    }
    return height; 
}

/** copyLadder:                                                                       - -
    This function hard copies the ladder linked list. This does not allocate new 
    C-strings but it allocates a new linked list.
    @param ladder   :   The "head"/top of the ladder.
    @return         :   The new copied node                                           */
WordNode* copyLadder(WordNode* ladder) {
    if (ladder == NULL) return NULL;

    WordNode* newLadder = (WordNode*) malloc(sizeof(WordNode));
    WordNode* res = newLadder;

    newLadder->myWord = ladder->myWord;
    newLadder->next = NULL;

    while (ladder->next != NULL) {
        // Create the next node:
        WordNode* nextNode = (WordNode*) malloc(sizeof(WordNode));
        nextNode->myWord = ladder->next->myWord;
        nextNode->next = NULL;
        
        // Build the nextNode for the newLadder:
        newLadder->next = nextNode;

        // Increment the original ladder and the new ladder:
        ladder = ladder->next;
        newLadder = newLadder->next;
    }
    return res; 
}

/** freeLadder:                                                                       - -
    This function frees the allocated ladder linked list. This does not free the
    C-strings that are the subitems of ladder.
    @param ladder   :   The "head"/top of the ladder.
    @return         :   None                                                          */
void freeLadder(WordNode* ladder) {
    while (ladder != NULL) {
        WordNode* nextTemp = ladder->next;
        free(ladder);
        ladder = nextTemp;
    }
}

/** insertLadderAtBack:                                                               - -
    This function builds the linked list of [LadderNode] by appending it at the back.
    Additionally, this function handles the case where list is initially NULL.
    @param list         :   This is a linked list of ladders.
    @param newLadder    :   This represents the head of a single ladder.
    @return             :   None                                                      */
void insertLadderAtBack(LadderNode** list, WordNode* newLadder) {
    // Create a new [LadderNode]:
    LadderNode* newLadderNode = (LadderNode*) malloc(sizeof(LadderNode));
    newLadderNode->topWord = newLadder;
    newLadderNode->next = NULL;

    // If the linked list is empty, then set it equal to the newLadderNode:
    if (*list == NULL) {
        *list = newLadderNode;
        return;
    }

    // With the newly created Node, insert it at the back of the list:
    LadderNode* cur = *list;
    while (cur->next) {
        cur = cur->next;
    }
    cur->next = newLadderNode;
}

/** popLadderFromFront:                                                               - -
    This function pops and returns the first node in the list.
    @param list :   This is a linked list of ladders.
    @return     :   Returns the first node's subitem topWord.                         */
WordNode* popLadderFromFront(LadderNode** list) {
    LadderNode* tempNext = (*list)->next;
    WordNode* ret = (*list)->topWord;
    free(*list);
    *list = tempNext;
    return ret;
}

/** freeLadderList:                                                                   - -
    This frees the all the ladders in the linked list except the C-strings.
    For each ladder in myList:
        Free up all the heap-allocated space of WordNode.
    Then free up the LadderNode itself.
    @param myList   :   This is a linked list of ladders.
    @return         :   None                                                          */
void freeLadderList(LadderNode* myList) {
    while (myList != NULL) {
        freeLadder(myList->topWord);
        LadderNode* tempNext = myList->next;
        free(myList);
        myList = tempNext;
    }
}

/** isNeighbor:                                                                       - -
    This function calculates the count of characters that are different comparing two
    strings. For example:
        str1 = wands, str2 = wants,     returns 1
        Thus, they are neighbors because they are only different by 1.
    @param str1 :   A C-string that possibly represents any word. 
    @param str2 :   Another C-string that possibly represents any word. 
    @return     :   Integer representing the number of differences of the strings.    */
int isNeighbor(char* str1, char* str2) {
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

/** findShortestWordLadder:                                                           - -
    This function is the main algorithm to find the shortest path to go from one word
    to another. This utilizes the BFS algorithm to check the combinations layer by
    layer. 
    @param words        :   A dynamically heap-allocated array of C-strings.
    @param usedWord     :   An array that is relative to words- representing used/not.
    @param numWords     :   The number of words to be initialized inside words.
    @param wordSize     :   The size of individual words in words. They are the same.
    @param startWord    :   The word that represents our starting path.
    @param finalWord    :   The word that is our end-goal.
    @return             :   The shortest linked list to go from startWord to 
                            finalWord.                                                */
WordNode* findShortestWordLadder(   char** words, 
                                    bool* usedWord, 
                                    int numWords, 
                                    int wordSize, 
                                    char* startWord, 
                                    char* finalWord ) {
    LadderNode* myList = NULL;
    WordNode* myLadder = NULL;
    insertWordAtFront(&myLadder, startWord);
    insertLadderAtBack(&myList, myLadder);
    while (myList != NULL) {
        myLadder = popLadderFromFront(&myList);
        for (int i = 0; i < numWords; i++) {
            // words[i] and myLadder->myWord must be neighbors. 
            // words[i] must not be used.
            if (isNeighbor(words[i], myLadder->myWord) != 1 || usedWord[i]) {
                continue;
            }
            if (strcmp(words[i], finalWord) == 0) {
                insertWordAtFront(&myLadder, words[i]);
                freeLadderList(myList);
                return myLadder;
            } else {
                WordNode* anotherLadder = copyLadder(myLadder);
                insertWordAtFront(&anotherLadder, words[i]);
                insertLadderAtBack(&myList, anotherLadder);
                usedWord[i] = true;
            }
        }
        freeLadder(myLadder);
    }

    return NULL;
}

// ----------------- everything past this line is not to be changed ------------------ 
// interactive user-input to set a word; 
//  ensures sure the word is in the dictionary word array
void setWord(char** words, int numWords, int wordSize, char* aWord) {
    bool valid = false;
    printf("  Enter a %d-letter word: ", wordSize);
    int count = 0;
    while (!valid) {
        scanf("%s",aWord);
        count++;
        valid = (strlen(aWord) == wordSize);
        if (valid) {
            int wordInd = findWord(words, aWord, 0, numWords-1);
            if (wordInd < 0) {
                valid = false;
                printf("    Entered word %s is not in the dictionary.\n",aWord);
                printf("  Enter a %d-letter word: ", wordSize); 
            }
        } else {
            printf("    Entered word %s is not a valid %d-letter word.\n",aWord,wordSize);
            printf("  Enter a %d-letter word: ", wordSize);
        }
        if (!valid && count >= 5) { //too many tries, picking random word
            printf("\n");
            printf("  Picking a random word for you...\n");
            strcpy(aWord,words[rand()%numWords]);
            printf("  Your word is: %s\n",aWord);
            valid = true;
        }
    }
}

// helpful debugging function to print a single Ladder
void printLadder(WordNode* ladder) {
    WordNode* currNode = ladder;
    while (currNode != NULL) {
        printf("\t\t\t%s\n",currNode->myWord);
        currNode = currNode->next;
    }
}

// helpful debugging function to print the entire list of Ladders
void printList(LadderNode* list) {
    printf("\n");
    printf("Printing the full list of ladders:\n");
    LadderNode* currList = list;
    while (currList != NULL) {
        printf("  Printing a ladder:\n");
        printLadder(currList->topWord);
        currList = currList->next;
    }
    printf("\n");
}

//-----------------------------------------------------
// The primary application is fully provided in main(); 
//  no changes should be made to main()
//-----------------------------------------------------
int main() {
    srand((int)time(0));
    printf("\nWelcome to the CS 211 Word Ladder Generator!\n\n");

    // set word length using interactive user-input
    int wordSize;
    printf("Enter the word size for the ladder: ");
    scanf("%d",&wordSize);
    printf("\n");

    printf("This program will make the shortest possible\n"); 
    printf("word ladder between two %d-letter words.\n\n",wordSize);
    
    // interactive user-input sets the dictionary file;
    //  check that file exists; if not, user enters another file
    //  if file exists, count #words of desired length [wordSize]
    char dict[100];
    printf("Enter filename for dictionary: ");
    scanf("%s", dict);
    printf("\n");
    int numWords = countWordsOfLength(dict,wordSize);
    while (numWords < 0) {
        printf("  Dictionary %s not found...\n",dict);
        printf("Enter filename for dictionary: ");
        scanf("%s", dict);
        printf("\n");
        numWords = countWordsOfLength(dict,wordSize);
    }

    // allocate heap memory for the word array; only words with desired length
    char** words = (char**)malloc(numWords*sizeof(char*));
    for (int i = 0; i < numWords; ++i) {
        words[i] = (char*)malloc((wordSize+1)*sizeof(char));
    }

    // end program if file does not have at least two words of desired length
    if (numWords < 2) {
        printf("  Dictionary %s contains insufficient %d-letter words...\n",dict,wordSize);
        printf("Terminating program...\n");
        return -1;
    }
    
    // [usedWord] bool array has same size as word array [words];
    //  all elements initialized to [false];
    //  later, usedWord[i] will be set to [true] whenever 
    //      words[i] is added to ANY partial word ladder;
    //      before adding words[i] to another word ladder,
    //      check for previous usage with usedWord[i] 
    bool* usedWord = (bool*)malloc(numWords*sizeof(bool));
    for (int i = 0; i < numWords; ++i) {
        usedWord[i] = false;
    }
    
    // build word array (only words with desired length) from dictionary file
    printf("Building array of %d-letter words... ", wordSize); 
    bool status = buildWordArray(dict,words,numWords,wordSize);

    if (!status) {
        printf("  ERROR in building word array.\n");
        printf("  File not found or incorrect number of %d-letter words.\n",wordSize);
        printf("Terminating program...\n");
        return -1;
    }
    printf("Done!\n"); 

    // set the two ends of the word ladder using interactive user-input
    //  make sure start and final words are in the word array, 
    //  have the correct length (implicit by checking word array), AND
    //  that the two words are not the same
    char startWord[30];
    char finalWord[30];
    printf("Setting the start %d-letter word... \n", wordSize);
    setWord(words, numWords, wordSize, startWord);
    printf("\n");
    printf("Setting the final %d-letter word... \n", wordSize);
    setWord(words, numWords, wordSize, finalWord);
    while (strcmp(finalWord,startWord) == 0) {
        printf("  The final word cannot be the same as the start word (%s).\n",startWord);
        printf("Setting the final %d-letter word... \n", wordSize);
        setWord(words, numWords, wordSize, finalWord);
    }
    printf("\n");

    // run the algorithm to find the shortest word ladder
    WordNode* myLadder = findShortestWordLadder(words, usedWord, numWords, wordSize, startWord, finalWord);

    // display word ladder and its height if one was found
    if (myLadder == NULL) {
        printf("There is no possible word ladder from %s to %s\n",startWord,finalWord);    
    } else {
        printf("Shortest Word Ladder found!\n");
        printLadder(myLadder);
    }
    printf("Word Ladder height = %d\n",getLadderHeight(myLadder));
    
    // free the heap-allocated memory for the shortest ladder
    freeLadder(myLadder);
    // free the heap-allocated memory for the words array
    freeWords(words,numWords);
    free(usedWord);
    
    return 0;
}
