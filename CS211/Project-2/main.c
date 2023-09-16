#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Org_struct {
    char name[20];
    int* prey; //dynamic array of indices  
    int numPrey;
} Org;


void buildWeb(Org* web, int numOrg, int predInd, int preyInd) {
    //TODO: build the web by adding the predator-prey relation to the food web.
    //      Inputs: 
    //          web - a dynamically allocated array of Orgs 
    //          numOrgs - number of organisms = size of web[]
    //          predInd - predator index in web[]; an entry to its prey[] subitem will be added
    //          preyInd - prey index in web[]; will be added to predator's prey[] subitem
    //      Outputs:
    //          web - array is updated and implicitly returned (previously allocated on heap)
    //        
    //      For the predator-prey relation...
    //      (1) if the predator's prey[] array is empty, allocate memory for one index
    //          otherwise, reallocate predator's prey[] array to allow one more index
    //      (2) append the prey index as the last element of the predator's prey[] array 
    //      (3) update the numPrey subitem for the predator appropriately 

    
    if (!web[predInd].numPrey) { // Case: prey array is empty, allocates memory for one int.
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


void extinction(Org** web, int* numOrgs, int index) {
    //TODO: remove the organism associated with [index] from web.
    //      Inputs: 
    //          web - a dynamically allocated array of Orgs 
    //          numOrgs - number of organisms = size of web[]
    //          index - organism index in web[] to remove
    //      Outputs:
    //          web - pointer passed-by-pointer; memory address of web array changes due to reallocation
    //          numOrgs - passed-by-pointer; must be decremented since web[] loses an organism
    //
    //      Remember to do the following:
    //      1. remove organism at index from web[] - DO NOT use realloc(), instead...
    //          (a) free any malloc'd memory associated with organism at index; i.e. its prey[] subitem
    //          (b) malloc new space for the array with the new number of Orgs
    //          (c) copy all but one of the old array elements to the new array, 
    //              some require shifting forward to overwrite the organism at index
    //          (d) free the old array
    //          (e) update the array pointer to the new array
    //          (f) update numOrgs
    //      2. remove index from all organsisms' prey[] array subitems - DO NOT use realloc(), instead...
    //          (a) search for index in all organisms' prey[] arrays; when index is found:
    //                [i] malloc new space for the array with the new number of ints
    //               [ii] copy all but one of the old array elements to the new array, 
    //                    keeping the same order some require shifting forward
    //              [iii] free the old array
    //               [iv] update the array pointer to the new array
    //                [v] update the numPrey subitem accordingly
    //          (b) update all organisms' prey[] elements that are greater than index, 
    //              which have been shifted forward in the web array
    //
    //          Edge case: check the size array being malloc'ed; 
    //                     for a web with only one organism and 
    //                     that orgranism goes extinct, 
    //                     instead of malloc'ing an empty array, 
    //                     explicitly set the pointer to NULL;
    //                     see the web[] allocation in main() as an example

}


// Food Web Predators & Prey:
//   Grass
//   Grasshopper eats Grass
//   Hawk eats Lizard, Mouse, Snake, Grasshopper, Rabbit
//   Lizard eats Grasshopper
//   Rabbit eats Grass
//   Snake eats Mouse
//   Mouse eats Grass
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

void printApexPredators(Org* web, int numOrg, bool apexPredators[]) {
    for (int i = 0; i < numOrg; i++) {
        if (apexPredators[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

void identifyProducers(Org* web, int numOrg, bool producers[]) {
    // Build the producers array based on whether the organism has eaten something or not.
    for (int i = 0; i < numOrg; i++) {
        if (!web[i].numPrey) { // If the organism has no prey, then it is a producer.
            producers[i] = 1;
        } else {               // Otherwise, it eats something.
            producers[i] = 0;
        }
    }
}

void printProducers(Org* web, int numOrg, bool producers[]) {
    for (int i = 0; i < numOrg; i++) {
        if (producers[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

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

void printFlexibleEaters(Org* web, int numOrg, bool mostFlexibleEaters[]) {
    for (int i = 0; i < numOrg; i++) {
        if (mostFlexibleEaters[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

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

void printTastiestFood(Org* web, int numOrg, bool tastiestFood[]) {
    for (int i = 0; i < numOrg; i++) {
        if (tastiestFood[i]) {
            printf("  %s\n", web[i].name);
        }
    }
}

void identifyFoodWebHeights(Org* web, int numOrg, int foodWebHeights[]) {
    // set all heights to 0
    // assume changes to the heights need to be made
    // visit all organisms in web[ ]
    // for each organism, set its height as one more than its maximum prey height
    // if no changes to the heights were made, then we are done; otherwise, redo step 3

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

void printFoodWebHeights(Org* web, int numOrg, int foodWebHeights[]) {
    for (int i = 0; i < numOrg; i++) {
        printf("  %s: %d\n", web[i].name, foodWebHeights[i]);
    }
}

void identifyVoreTypes(Org* web, int numOrg, int voreTypes[], bool producers[]) {
    // Producer (1): eats no other organism in the food web; the assumption is that all producers are plants and all plants are producers.
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

// Vore Types:
//   Producers:
//     Grass
//   Herbivores:
//     Grasshopper
//     Rabbit
//     Mouse
//   Omnivores:
//   Carnivores:
//     Hawk
//     Lizard
//     Snake
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

    printf("Food Web Predators & Prey:\n");
    printFoodWeb(web, numOrgs);
    printf("\n");

    printf("Apex Predators:\n");
    bool apexPredators[numOrgs]; // Index: Respective org, Value: 1, 0 indicating whether the org is a predator or not.
    identifyApexPredators(web, numOrgs, apexPredators);
    printApexPredators(web, numOrgs, apexPredators);

    printf("\n");

    printf("Producers:\n");
    bool producers[numOrgs]; // Index: Respective org, Value: 1, 0 indicating whether the org is a producer or not.
    identifyProducers(web, numOrgs, producers);
    printProducers(web, numOrgs, producers);
    printf("\n");

    printf("Most Flexible Eaters:\n");
    bool mostFlexibleEaters[numOrgs]; // Index: Respective org, Value: 1, 0 indicating whether the org is the most flexible eater or not. 
    identifyFlexibleEaters(web, numOrgs, mostFlexibleEaters);
    printFlexibleEaters(web, numOrgs, mostFlexibleEaters);

    printf("\n");

    printf("Tastiest Food:\n");
    bool tastiestFood[numOrgs];
    identifyTastiestFood(web, numOrgs, tastiestFood);
    printTastiestFood(web, numOrgs, tastiestFood);

    printf("\n");

    printf("Food Web Heights:\n");
    int foodWebHeights[numOrgs]; // Index: Respective org, Value: the web height of the org.
    identifyFoodWebHeights(web, numOrgs, foodWebHeights);
    printFoodWebHeights(web, numOrgs, foodWebHeights);

    printf("\n");

    printf("Vore Types:\n");
    int voreTypes[numOrgs]; // Index: Respective org, Value: 1 -> Producer, 2 -> Herbivore, 3 -> Omnivore, 4 -> Carnivore
    identifyVoreTypes(web, numOrgs, voreTypes, producers);
    printVoreTypes(web, numOrgs, voreTypes);

    printf("\n");

    printf("--------------------------------\n");
    int extInd;
    printf("Enter extinct species index:\n");
    scanf("%d",&extInd);
    printf("Species Extinction: %s\n", web[extInd].name);
    extinction(&web,&numOrgs,extInd);
    printf("--------------------------------\n\n");


    printf("UPDATED Food Web Predators & Prey:\n");
    //TODO: print the UPDATED Food Web Organisms with what they eat (i.e. prey), AFTER THE EXTINCTION
    printf("\n");

    printf("UPDATED Apex Predators:\n");
    //TODO: AFTER THE EXTINCTION, identify and print the organisms not eaten by any other
    printf("\n");

    printf("UPDATED Producers:\n");
    //TODO: AFTER THE EXTINCTION, identify and print the organisms that eat no other organisms
    printf("\n");

    printf("UPDATED Most Flexible Eaters:\n");
    //TODO: AFTER THE EXTINCTION, identity and print the organism(s) with the most prey
    printf("\n");

    printf("UPDATED Tastiest Food:\n");
    //TODO: AFTER THE EXTINCTION, identity and print organism(s) eaten by the most other organisms
    printf("\n");

    printf("UPDATED Food Web Heights:\n");
    //TODO: AFTER THE EXTINCTION, calculate and print the length of the longest chain from a 
    //      producer to each organism
    printf("\n");

    printf("UPDATED Vore Types:\n");
    //TODO: AFTER THE EXTINCTION, classify all organisms and print each group
    //      (producers, herbivores, omnivores, & carnivores)
    printf("\n");
    printf("--------------------------------\n");

    //TODO: make sure to free all malloc'd memory to prevent potential leaks

    return 0;
}
