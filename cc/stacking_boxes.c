#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define NUM_BUF_SIZE 22 // length_of(2^64) + 1

// IO routines

int _eof;

int freadnum(FILE *stream) {
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
    if (c == EOF && buf[0] == '\0') { _eof = 1; return 0; }
    int r = strtoll(buf, NULL, 10);
    free(buf);
    return r;
}

int readnum() {
    return freadnum(stdin);
}

void freadnums(FILE *stream, int *out, size_t s) {

    int i;
    for (i = 0; i < s; i++) {
        out[i] = readnum(stream);
    }
}

void readnums(int *out, size_t s) {
    return freadnums(stdin, out, s);
}

typedef struct Box {
    short order;
    int *dimensions;
    struct Box *nested;
    short weight;
    short dnum;
} Box;

typedef struct BoxSet {
    short size;
    short dnum;
    Box *boxes;
} BoxSet;

int int_compare(const void *a, const void *b) {
    return *((int *) a) > *((int *) b);
}

int box_compare(const void *a, const void *b) {
    Box *box_a = (Box *) a;
    Box *box_b = (Box *) b;
    int i;
    for (i = 0; i < box_a->dnum; i++) {
        int ir = box_a->dimensions[i] - box_b->dimensions[i];
        if (ir != 0) { return ir; }
    }
    return 0;
}

int box_fits(const Box *inner, const Box *outer) {
    int i;
    for (i = 0; i < inner->dnum; i++) {
        if (inner->dimensions[i] >= outer->dimensions[i]) {
            return 0;
        }
    }
    return 1;
}

int signum(int x) {
    return (x > 0) - (x < 0);
}

/**
 * Detect "equal" boxes. Boxes A is equal to box B is and only if it has
 * at least one equal dimension (or more) and all other dimensions are less then
 * the appropriate ones.
 *
 * @param a
 * @param b
 * @return Box to remain (the lesser one). Or NULL if boxes are not equal.
 */
Box *box_min(Box *box_a, Box *box_b) {
    int i = 0;
    int ab_dif,
            a_min = 0,
            b_min = 0,
            ab_eq = 0;
    for (i = 0; i < box_a->dnum; i++) {
        ab_dif = box_a->dimensions[i] - box_b->dimensions[i];
        if (ab_dif < 0) {
            a_min = 1;
        } else if (ab_dif > 0) {
            b_min = 1;
        } else {
            ab_eq = 1;
        }
    }

    if (ab_eq && !b_min) {
        return box_a;
    } else if (ab_eq && !a_min) {
        return box_b;
    }
    return NULL;
}

void print_rec(Box *b) {

    if (b != NULL) {
        print_rec(b->nested);
        if (b->nested != NULL) { printf(" "); }
        printf("%d", b->order);
    }
}

void box_set() {

    BoxSet bs;

    _eof = 0;
    bs.size = readnum();
    if (_eof) { exit(EXIT_SUCCESS); }
    bs.dnum = readnum();
    bs.boxes = malloc(bs.size * sizeof(Box));

    int i;
    for (i = 0; i < bs.size; i++) {
        bs.boxes[i].order = i + 1;
        bs.boxes[i].nested = NULL;
        bs.boxes[i].weight = 0;
        bs.boxes[i].dnum = bs.dnum;
        bs.boxes[i].dimensions = malloc(bs.dnum * sizeof(int));
        readnums(bs.boxes[i].dimensions, bs.dnum);
    }

    int (*comp)(const void *, const void *);

    comp = int_compare;
    for (i = 0; i < bs.size; i++) {
        qsort(bs.boxes[i].dimensions, bs.dnum, sizeof(int), comp);
    }

    comp = box_compare;
    qsort(bs.boxes, bs.size, sizeof(Box), comp);

    Box *root = &bs.boxes[0];
    root->weight = 1;

    // build graph
    int j;
    Box *inner, *outer;
    Box *max = root;
    for (i = 1; i < bs.size; i++) {
        outer = &bs.boxes[i];
        // go backwards and compare with every box
        for (j = i - 1; j >= 0; j--) {
            inner = &bs.boxes[j];
            if (box_fits(inner, outer) && inner->weight >= outer->weight) {
                outer->nested = inner;
                outer->weight = inner->weight + 1;
            }
        }
        if (outer->nested == NULL) {
            outer->weight = 1;
        }
        if (outer->weight > max->weight) {
            max = outer;
        }
    }

    // build sequence
    Box *b = max;
    printf("%d\n", max->weight);
    print_rec(max);
    printf("\n");

    for (i = 0; i < bs.size; i++) {
        free(bs.boxes[i].dimensions);
    }
    free(bs.boxes);
}

int main(int argc, char** argv) {

    _eof = 0;
    while (1) {
        box_set();
    }

    return (EXIT_SUCCESS);
}

