#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

// IO routines

#define NUM_BUF_SIZE 22 // length_of(2^64) + 1

int32_t readnum(FILE *stream) {
    int c, i;
    char *buf = malloc(NUM_BUF_SIZE);
    for (i = 0; i < NUM_BUF_SIZE; i++) {
        c = fgetc(stream);
        if (c == 0x20 || c == 0x09 || c == 0x0D || c == 0x0A || c == EOF ) { // space
            if (i == 0 && c != EOF) { // extra space to be ignored, except EOF
                --i; // will be re-incremented to 0 by loop
                continue;
            }
            buf[i] = '\0';
            break;
        }
        buf[i] = c;
    }
    int32_t r = strtoll(buf, NULL, 10);
    free(buf);
    return r;
}

// Main

typedef uint32_t int_l;
typedef uint64_t long_l;

typedef struct SortedList {
    int_l *source_array;
    int_l *buffer_array;
    long_l inversions;
} SortedList;

void merge_and_count(SortedList *sl, int_l from_idx, int_l med, int_l to_idx) {

    int_l i = from_idx,
          j = med,
          k = from_idx;

    for (; k < to_idx; k++) {

        // end case: append the rest
        if (i == med) {
            for (; j < to_idx; j++) {
                sl->source_array[k++] = sl->buffer_array[j];
            }
            break;
        }
        if (j == to_idx) {
            for (; i < med; i++) {
                sl->source_array[k++] = sl->buffer_array[i];
            }
            break;
        }

        // merge
        int_l lval = sl->buffer_array[i];
        int_l rval = sl->buffer_array[j];
        if (lval <= rval) {
            sl->source_array[k] = lval;
            i++;
        } else {
            // fprintf(stderr, "INV: %d <-- %d\n", lval, rval);
            sl->source_array[k] = rval;
            sl->inversions += (med - i);
            j++;
        }
    }
    memcpy(&(sl->buffer_array[from_idx]),
           &(sl->source_array[from_idx]),
           (to_idx - from_idx) * sizeof(int_l));
}

void sort_and_count(SortedList *sl, int_l from_idx, int_l to_idx) {

    int_l length = to_idx - from_idx;

    // end case
    if (length == 1) { return; }

    int_l left_size = length / 2;
    int_l right_size = length - left_size;
    int_l med = from_idx + left_size;

    sort_and_count(sl, from_idx, med);
    sort_and_count(sl, med, to_idx);

    merge_and_count(sl, from_idx, med, to_idx);
}

long_l count_inversions(int_l input_size, int_l *input_array) {
    int_l *buffer_array = malloc(sizeof(int_l) * input_size);
    memcpy(buffer_array, input_array, sizeof(int_l) * input_size);
    SortedList sl;
    sl.source_array = input_array;
    sl.buffer_array = buffer_array;
    sl.inversions = 0;
    int m;
    sort_and_count(&sl, 0, input_size);
    return sl.inversions;
}

int main(int argc, char *argv[]) {
    // int_l input_size = readnum(stdin);
    int_l input_size = strtol(argv[1], NULL, 10);
    int_l i;
    int_l *input_array = malloc(input_size * sizeof(int_l));
    for (i = 0; i < input_size; i++) {
        input_array[i] = readnum(stdin);
    }
    printf("%u\n", count_inversions(input_size, input_array));
}


