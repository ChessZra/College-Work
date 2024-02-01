/*
 * File: hashcode.h
 * ------------------
 * This file implements the interface declared in hashcode.h.
 * 
 * @version 2015/07/05
 * - using global hashing functions rather than global variables
 */

//#include "hashcode.h"

#ifndef _hashcode_h
#define _hashcode_h

#include <string>
#include <utility>

static const int HASH_SEED = 5381;               // Starting point for first cycle
static const int HASH_MULTIPLIER = 33;           // Multiplier for each cycle
static const int HASH_MASK = unsigned(-1) >> 1;  // All 1 bits except the sign

int hashSeed() {
    return HASH_SEED;
}

int hashMultiplier() {
    return HASH_MULTIPLIER;
}

int hashMask() {
    return HASH_MASK;
}

/*
 * Implementation notes: hashCode
 * ------------------------------
 * This function takes a string key and uses it to derive a hash code,
 * which is a nonnegative integer related to the key by a deterministic
 * function that distributes keys well across the space of integers.
 * The general method is called linear congruence, which is also used
 * in random-number generators.  The specific algorithm used here is
 * called djb2 after the initials of its inventor, Daniel J. Bernstein,
 * Professor of Mathematics at the University of Illinois at Chicago.
 */

int hashCode(bool key) {
    return (int) key;
}

int hashCode(char key) {
    return key;
}

int hashCode(double key) {
    char* byte = (char*) &key;
    unsigned hash = HASH_SEED;
    for (int i = 0; i < (int) sizeof(double); i++) {
        hash = HASH_MULTIPLIER * hash + (int) *byte++;
    }
    return hash & HASH_MASK;
}

int hashCode(float key) {
    char* byte = (char*) &key;
    unsigned hash = HASH_SEED;
    for (int i = 0; i < (int) sizeof(float); i++) {
        hash = HASH_MULTIPLIER * hash + (int) *byte++;
    }
    return hash & HASH_MASK;
}

int hashCode(int key) {
    return key & HASH_MASK;
}

int hashCode(long key) {
    return int(key) & HASH_MASK;
}

int hashCode(const char* str) {
    unsigned hash = HASH_SEED;
    for (int i = 0; str && str[i] != 0; i++) {
        hash = HASH_MULTIPLIER * hash + str[i];
    }
    return int(hash & HASH_MASK);
}

int hashCode(const std::string& str) {
    unsigned hash = HASH_SEED;
    int n = str.length();
    for (int i = 0; i < n; i++) {
        hash = HASH_MULTIPLIER * hash + str[i];
    }
    return int(hash & HASH_MASK);
}

int hashCode(void* key) {
    return hashCode(reinterpret_cast<long>(key));
}

/*
 * Computes a composite hash code from a list of multiple values.
 * The components are scaled up so as to spread out the range of values
 * and reduce collisions.
 * The type of each value passed must have a suitable hashCode() function.
 */
template <typename T1, typename T2, typename... Others>
int hashCode(T1&& first, T2&& second, Others&&... remaining) {
    int result = hashSeed();

    /* Compute the hash code for the last n - 1 arguments. */
    result += hashCode(std::forward<T2>(second), std::forward<Others>(remaining)...);

    /* Update the hash to factor in the hash of the first element. */
    result *= hashMultiplier();
    result += hashCode(std::forward<T1>(first));

    /* Hash the resulting integer to mask off any unneeded bits. */
    return hashCode(result);
}

#endif // _hashcode_h
