/* -----------------------------------------------------------------------------------
Program 2: Food Web Analysis with Dynamic Memory
Course: CS 211, Fall 2023, UIC
System: Advanced zyLab
Author: John Ezra See
- -               - -
Description: This program analyzes food webs, letting users define predator-prey 
relationships. It dynamically manages organism data and handles species extinctions,
updating the food web accordingly.
------------------------------------------------------------------------------------- */
// Preproccesor directives:

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Org_struct {
    char name[20];
    int* prey; //dynamic array of indices  
    int numPrey;
} Org;

/** buildWeb:                                                                         - -
    This function builds the predator-prey relationships in the prey subitem for every 
    Org in web. This function initializes the web parameter.
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param predInd      : The respective index of predator in the web.
    @param preyInd      : The respective index of prey in the web.
    @return             : Changes web parameter by reference.                         */
void buildWeb(Org* web, int numOrg, int predInd, int preyInd) {
    if (!web[predInd].numPrey) { // Case: prey array is empty, allocates memory for
                                 // one int.
        web[predInd].prey = (int*) malloc(sizeof(int));
    } else { // Case: prey array is not empty, allocates memory for one extra int.
        // Allocate a new prey array with the new size.
        // Copy the old elements to the new prey array.
        // Free up the old array.
        // Repipe the old array to the new array.
        int* newPrey = (int*) malloc(sizeof(int) * (web[predInd].numPrey + 1));
        for (int i = 0; i < web[predInd].numPrey; i++) {
            newPrey[i] = web[predInd].prey[i];
        }
        free(web[predInd].prey);
        web[predInd].prey = newPrey;
    }

    // (2) append the prey index as the last element of the predator's prey[] array 
    web[predInd].prey[web[predInd].numPrey] = preyInd;

    // (3) update the numPrey subitem for the predator appropriately 
    web[predInd].numPrey += 1;
}

/** extinction:                                                                       - -
    This function handles the web by updating all the predator-prey relationships
    and removing the extinct index from the web and the prey[] array.
    @param web          : A pointer of array pointer of organisms.
    @param numOrgs      : The number of organisms in web (i.e size of the web).
    @param Index        : The respective index of the extinct specimen.
    @return             : Changes web and numOrgs parameter by reference.             */
void extinction(Org** web, int* numOrgs, int index) {
    // Purpose: Remove extinct organism at index from web[].
    free((*web)[index].prey); // free up dynamically allocated prey array subitem 
    Org* newArr = (*numOrgs - 1) ? (Org*) malloc((*numOrgs - 1) * sizeof(Org)) : NULL;

    int j = 0;
    for (int i = 0; i < *numOrgs; i++) {
        if (i == index) continue;
        newArr[j] = (*web)[i];
        j += 1;
    }
    free(*web);
    *web = newArr;
    *numOrgs -= 1;

    // Purpose: Remove index from all organisms' prey[] array subitems.
    for (int i = 0; i < *numOrgs; i++) {
    
        // Step 1: Find if the extinct organism exists in prey[].
        bool extinctPreyFound = false;
        for (int j = 0; j < (*web)[i].numPrey; j++) {
            if ((*web)[i].prey[j] == index) 
                extinctPreyFound = true;
        }

        // Step 2: Allocate a new array properly.
        int* newPrey = NULL;
        if (extinctPreyFound && (*web)[i].numPrey > 1) { // Case: Extinct organism is 
                                                // found, we would like to remove that
                                                // so allocate a new array of size - 1
            newPrey = (int*) malloc(sizeof(int) * ((*web)[i].numPrey - 1));
        } else if (!extinctPreyFound && (*web)[i].numPrey) {
            newPrey = (int*) malloc(sizeof(int) * (*web)[i].numPrey);
        }

        // Step 3: Populate the allocated array.
        int k = 0;
        for (int j = 0; j < (*web)[i].numPrey; j++) {
            int preyInd = (*web)[i].prey[j];
            if (preyInd == index) {
                continue;
            } else if (preyInd > index) {
                newPrey[k++] = preyInd - 1;
            } else {
                newPrey[k++] = preyInd;
            }
        }
        
        // Step 4: Free up the old prey array and re-assign it to the new one.
        free((*web)[i].prey);
        (*web)[i].prey = newPrey;

        // Step 5: Update numprey subitem.
        if (extinctPreyFound) {
            (*web)[i].numPrey -= 1;
        }
    }

}

/** printFoodWeb:                                                                     - -
    This function prints the food web. (e.g Lion eats eagle)
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @return             : None                                                        */
void printFoodWeb(Org* web, int numOrg) {
    for (int i = 0; i < numOrg; i++) {
        printf("  %s", web[i].name);
        if (web[i].numPrey) 
            printf(" eats ");
        for (int j = 0; j < web[i].numPrey; j++) {
            if (j == (web[i].numPrey - 1)) {
                printf("%s", web[web[i].prey[j]].name);
            } else {
                printf("%s, ", web[web[i].prey[j]].name);
            }
        }
        printf("\n");
    }
}

/** identifyApexPredators:                                                            - -
    This function initializes the apex predators by traversing every single animal on 
    the web to see if they are an apex predator or not.
    @param web              : An array pointer of organisms.
    @param numOrg           : The number of organisms in web (i.e size of the web).
    @param apexPredators    : A static array: index: respective animal index.
                              value: 1 -> predator, 0 -> not predator.
    @return                 : Changes the apexPredators array.                        */
void identifyApexPredators(Org* web, int numOrg, bool apexPredators[]) {
    // Initialize every organism as a predator.
    for (int i = 0; i < numOrg; i++) {
        apexPredators[i] = 1;
    }
    
    // Filter non-predators based on whether they appear in the prey[] arrays.
    for (int i = 0; i < numOrg; i++) {
        for (int j = 0; j < web[i].numPrey; j++) {
            int preyIndex = web[i].prey[j];
            apexPredators[preyIndex] = 0;
        }
    }
}

/** printApexPredators:                                                               - -
    This function prints the apex predators.
    @param web              : An array pointer of organisms.
    @param numOrg           : The number of organisms in web (i.e size of the web).
    @param apexPredators    : A static array: index: respective animal index.
                              value: 1 -> predator, 0 -> not predator.
    @return                 : None.                                                   */
void printApexPredators(Org* web, int numOrg, bool apexPredators[]) {
    for (int i = 0; i < numOrg; i++) {
        if (apexPredators[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

/** identifyProducers:                                                                - -
    This function initializes the producers by traversing every single animal on the web
    to see if they are a producer or not.
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param producers    : A static array: index: respective animal index
                          value: 1 -> producer, 0 -> not producer.
    @return             : Changes the producers array.                                */
void identifyProducers(Org* web, int numOrg, bool producers[]) {
    // Build the producers array based on whether the organism has eaten something or 
    // not.
    for (int i = 0; i < numOrg; i++) {
        if (!web[i].numPrey) { // If the organism has no prey, then it is a producer.
            producers[i] = 1;
        } else {               // Otherwise, it eats something.
            producers[i] = 0;
        }
    }
}

/** printProducers:                                                                   - -
    This function prints the producers.
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param producers    : A static array: index: respective animal index
                          value: 1 -> producer, 0 -> not producer.
    @return             : None                                                        */
void printProducers(Org* web, int numOrg, bool producers[]) {
    for (int i = 0; i < numOrg; i++) {
        if (producers[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

/** identifyFlexibleEaters:                                                           - -
    This function initializes the mostFlexibleEaters array by going through the web 
    and checking who eats the most diversed animals.
    @param web                  : An array pointer of organisms.
    @param numOrg               : The number of organisms in web (i.e size of the web).
    @param mostFlexibleEaters   : A static array: index: respective animal index.
                                  value: 1 -> flexible eater, 0 -> the opposite.
    @return                     : Changes the mostFlexibleEaters array.               */
void identifyFlexibleEaters(Org* web, int numOrg, bool mostFlexibleEaters[]) {
    // Get max number of eaten preys.
    int maxPreys = 0;
    for (int i = 0; i < numOrg; i++) {
        if (web[i].numPrey > maxPreys) {
            maxPreys = web[i].numPrey;
        }
    }

    // Build mostFlexibleEaters[] array based on the calculated maxPreys number.
    for (int i = 0; i < numOrg; i++) {
        if (web[i].numPrey == maxPreys) {
            mostFlexibleEaters[i] = 1;
        } else {
            mostFlexibleEaters[i] = 0;
        }
    }
}

/** printFlexibleEaters:                                                              - -
    This function prints the most flexible eaters.
    @param web                  : An array pointer of organisms.
    @param numOrg               : The number of organisms in web (i.e size of the web).
    @param mostFlexibleEaters   : A static array: index: respective animal index,
                                  value: 1 -> flexible eater, 0 -> the opposite.
    @return                     : None                                                */
void printFlexibleEaters(Org* web, int numOrg, bool mostFlexibleEaters[]) {
    for (int i = 0; i < numOrg; i++) {
        if (mostFlexibleEaters[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

/** identifyTastiestFood:                                                             - -
    This function initializes the tastiestFood array by checking which animal in the web
    is most prone to being a prey.
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param tastiestFood : A static array: index: respective animal index,
                          value: 1 -> tasty food, 0 -> non-tasty.
    @return             : Changes the tastiestFood array.                             */
void identifyTastiestFood(Org* web, int numOrg, bool tastiestFood[]) {
    // Get max number of eaten preys.
    int numTimesEaten[numOrg];
    int maxNumTimes = 0;
    for (int i = 0; i < numOrg; i++) {
        numTimesEaten[i] = 0;
    }

    for (int i = 0; i < numOrg; i++) {
        for (int j = 0; j < web[i].numPrey; j++) {
            int preyIndex = web[i].prey[j];
            numTimesEaten[preyIndex] += 1;
            if (numTimesEaten[preyIndex] > maxNumTimes) {
                maxNumTimes = numTimesEaten[preyIndex];
            }
        }
    }

    for (int i = 0; i < numOrg; i++) {
        tastiestFood[i] = 0;
        if (numTimesEaten[i] == maxNumTimes) 
            tastiestFood[i] = 1;
    }
}

/** printTastiestFood:                                                                - -
    This function prints the tastiest animal.
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param tastiestFood : A static array: index: respective animal index,
                          value: 1 -> tasty food, 0 -> non-tasty
    @return             : None                                                        */
void printTastiestFood(Org* web, int numOrg, bool tastiestFood[]) {
    for (int i = 0; i < numOrg; i++) {
        if (tastiestFood[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

/** printFoodWebHeights:                                                              - -
    This function analyzes the height of each food using a certain algorithm:
    the path from the producer up to that point. This function is to initialize 
    the foodWebHeights array.
    @param web              : An array pointer of organisms.
    @param numOrg           : The number of organisms in web (i.e size of the web).
    @param foodWebHeights   : A static array: index: respective animal index
                              value: the height (path)
    @return                 : Changes the foodWebHeights array.                       */
void identifyFoodWebHeights(Org* web, int numOrg, int foodWebHeights[]) {
    // set all heights to 0
    // assume changes to the heights need to be made
    // visit all organisms in web[ ]
    // for each organism, set its height as one more than its maximum prey height
    // if no changes to the heights were made, then we are done; otherwise, redo      
    // step 3

    for (int i = 0; i < numOrg; i++) {
        foodWebHeights[i] = 0;
    }

    bool changes = true;
    while (changes) {
        changes = false;
        for (int i = 0; i < numOrg; i++) {
            int maxPreyHeight = -1;
            for (int j = 0; j < web[i].numPrey; j++) {
                if (foodWebHeights[web[i].prey[j]] > maxPreyHeight) 
                    maxPreyHeight = foodWebHeights[web[i].prey[j]];
            }
            if (foodWebHeights[i] != (maxPreyHeight + 1)) {
                foodWebHeights[i] = maxPreyHeight + 1;
                changes = true;
            }
        }
    }
}

/** printFoodWebHeights:                                                              - -
    This function prints the height of each food.
    @param web              : An array pointer of organisms.
    @param numOrg           : The number of organisms in web (i.e size of the web).
    @param foodWebHeights   : A static array: index: respective animal index
                              value: the height (path)
    @return                 : None                                                    */
void printFoodWebHeights(Org* web, int numOrg, int foodWebHeights[]) {
    for (int i = 0; i < numOrg; i++) {
        printf("  %s: %d\n", web[i].name, foodWebHeights[i]);
    }
}

/** printVoreTypes:                                                                   - -
    This function categorizes every single animal to their respective type.

    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param voreTypes    : A static array: index: respective animal index
                                    value: the type of vore.
    @param producers    : A static array: index: respective animal index
                          value: 1 -> producer, 0 -> not producer.
    @return             : Changes the voreTypes array.                                */
void identifyVoreTypes(Org* web, int numOrg, int voreTypes[], bool producers[]) {
    // Producer (1): eats no other organism in the food web; the assumption is that 
                            //all producers are plants and all plants are producers.
    // Herbivore (2): only eat producers (i.e. only plants)
    // Omnivore (3): eats producers and non-producers (i.e. plants and animals)
    // Carnivore (4): only eats non-producers (i.e. only animals)
    for (int i = 0; i < numOrg; i++) {
        bool eatsAnimals = false, eatsPlants = false;
        for (int j = 0; j < web[i].numPrey; j++) {
            int orgIndex = web[i].prey[j];
            if (producers[orgIndex]) {
                eatsPlants = true;
            } else {
                eatsAnimals = true;
            }
        }
        if (!eatsAnimals && !eatsPlants) {
            voreTypes[i] = 1;
        } else if (!eatsAnimals && eatsPlants) {
            voreTypes[i] = 2;
        } else if (eatsAnimals && eatsPlants) {
            voreTypes[i] = 3;
        } else if (eatsAnimals && !eatsPlants) {
            voreTypes[i] = 4;
        }
    }
}

/** printVoreTypes:                                                                   - -
    This function prints the type of Vore for each animal.
    @param web          : An array pointer of organisms.
    @param numOrg       : The number of organisms in web (i.e size of the web).
    @param voreTypes    : A static array: index: respective animal index
                          value: the type of vore.
    @return             : None                                                        */
void printVoreTypes(Org* web, int numOrg, int voreTypes[]) {
    for (int i = 1; i <= 4; i++) {
        if (i == 1) {
            printf("  Producers:\n");
        }  else if (i == 2) {
            printf("  Herbivores:\n");
        } else if (i == 3) {
            printf("  Omnivores:\n");
        } else if (i == 4) {
            printf("  Carnivores:\n");
        }

        for (int j = 0; j < numOrg; j++) {
            if (voreTypes[j] == i) 
                printf("    %s\n", web[j].name);
        }
    }
}

/** main:
    The driver code of the program. This is where the code starts.
    @return     : integer to signify successful program execution.                    */
int main(void) {

    int numOrgs;
    printf("Welcome to the Food Web Application\n");
    printf("--------------------------------\n");
    printf("Enter number of organisms:\n");
    scanf("%d",&numOrgs);

    Org* web = NULL;
    if(numOrgs > 0) { //Do not malloc an empty array, leave it pointing to NULL
        web = (Org*)malloc(numOrgs*sizeof(Org));
    }
    
    printf("Enter names for %d organisms:\n", numOrgs);
    for (int i = 0; i < numOrgs; ++i) {
        scanf("%s",web[i].name);
        web[i].prey = NULL;
        web[i].numPrey = 0;
    }

    printf("Enter number of predator/prey relations:\n");
    int numRels;
    scanf("%d",&numRels);

    printf("Enter the pair of indices for the %d predator/prey relations\n",numRels);
    printf("the format is [predator index] [prey index]:\n");
    
    int predInd, preyInd;
    for (int i = 0; i < numRels; ++i) {
        scanf("%d %d",&predInd, &preyInd);
        buildWeb(web,numOrgs,predInd,preyInd);
    }
    printf("--------------------------------\n\n");
    /* --------------------------- Identify/Print section --------------------------- */
    printf("Food Web Predators & Prey:\n");
    printFoodWeb(web, numOrgs);
    printf("\n");

    printf("Apex Predators:\n");
    bool apexPredators[numOrgs]; // Index: Respective org, Value: 1, 0 indicating 
                                 // whether the org is a predator or not.
    identifyApexPredators(web, numOrgs, apexPredators);
    printApexPredators(web, numOrgs, apexPredators);
    printf("\n");

    printf("Producers:\n");
    bool producers[numOrgs]; // Index: Respective org, Value: 1, 0 indicating whether 
                             // the org is a producer or not.
    identifyProducers(web, numOrgs, producers);
    printProducers(web, numOrgs, producers);
    printf("\n");

    printf("Most Flexible Eaters:\n");
    bool mostFlexibleEaters[numOrgs]; // Index: Respective org, Value: 1, 0 indicating 
                                      // whether the org is the most flexible eater 
                                      // or not. 
    identifyFlexibleEaters(web, numOrgs, mostFlexibleEaters);
    printFlexibleEaters(web, numOrgs, mostFlexibleEaters);
    printf("\n");

    printf("Tastiest Food:\n");
    bool tastiestFood[numOrgs];
    identifyTastiestFood(web, numOrgs, tastiestFood);
    printTastiestFood(web, numOrgs, tastiestFood);
    printf("\n");

    printf("Food Web Heights:\n");
    int foodWebHeights[numOrgs]; // Index: Respective org, Value: the web height of 
                                // the org.
    identifyFoodWebHeights(web, numOrgs, foodWebHeights);
    printFoodWebHeights(web, numOrgs, foodWebHeights);
    printf("\n");

    printf("Vore Types:\n");
    int voreTypes[numOrgs]; // Index: Respective org, Value: 1 -> Producer, 
                            // 2 -> Herbivore, 3 -> Omnivore, 4 -> Carnivore
    identifyVoreTypes(web, numOrgs, voreTypes, producers);
    printVoreTypes(web, numOrgs, voreTypes);
    printf("\n");

    /* --------------------------- Extinction section ------------------------------- */
    printf("--------------------------------\n");
    int extInd;
    printf("Enter extinct species index:\n");
    scanf("%d",&extInd);
    printf("Species Extinction: %s\n", web[extInd].name);
    extinction(&web,&numOrgs,extInd);
    printf("--------------------------------\n\n");
    

    printf("UPDATED Food Web Predators & Prey:\n");
    printFoodWeb(web, numOrgs);
    printf("\n");

    printf("UPDATED Apex Predators:\n");
    apexPredators[numOrgs];
    identifyApexPredators(web, numOrgs, apexPredators);
    printApexPredators(web, numOrgs, apexPredators);
    printf("\n");

    printf("UPDATED Producers:\n");
    producers[numOrgs]; 
    identifyProducers(web, numOrgs, producers);
    printProducers(web, numOrgs, producers);
    printf("\n");

    printf("UPDATED Most Flexible Eaters:\n");
    mostFlexibleEaters[numOrgs]; 
    identifyFlexibleEaters(web, numOrgs, mostFlexibleEaters);
    printFlexibleEaters(web, numOrgs, mostFlexibleEaters);
    printf("\n");

    printf("UPDATED Tastiest Food:\n");
    tastiestFood[numOrgs];
    identifyTastiestFood(web, numOrgs, tastiestFood);
    printTastiestFood(web, numOrgs, tastiestFood);
    printf("\n");

    printf("UPDATED Food Web Heights:\n");
    foodWebHeights[numOrgs];
    identifyFoodWebHeights(web, numOrgs, foodWebHeights);
    printFoodWebHeights(web, numOrgs, foodWebHeights);
    printf("\n");

    printf("UPDATED Vore Types:\n");
    voreTypes[numOrgs]; 
    identifyVoreTypes(web, numOrgs, voreTypes, producers);
    printVoreTypes(web, numOrgs, voreTypes);
    printf("\n");
    printf("--------------------------------\n");

    // Free up all of the allocated memory.
    for (int i = 0; i < numOrgs; i++) {
        free(web[i].prey);
    }
    free(web);
    return 0;
}
