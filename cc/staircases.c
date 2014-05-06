#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define NUM_BUF_SIZE 22 // length_of(2^64) + 1

int readnum(FILE *stream) {
    int c, i;
    char *buf = malloc(NUM_BUF_SIZE);
    for (i = 0; i < NUM_BUF_SIZE; i++) {
        c = fgetc(stream);
        if (c == 0x20 || c == 0x09 || c == 0x0D || c == 0x0A || c == EOF ) { // space
            buf[i] = '\0';
            break;
        }
        buf[i] = c;
    }
    c = atoi(buf);
    free(buf);
    return c;
}

long int ncols(int bricks, int columns, long int result) {
    if (bricks <= 0) { return result; }
    if (columns == 1) { return result + 1; }

    result = ncols(bricks - columns, columns - 1, result);
    return ncols(bricks - columns, columns, result);
}

long int max_columns(int bricks) {
    return (long int) floor(sqrt(bricks * 2) + 0.5d) + 1;
}

long int solve(int bricks) {
    long int max_cols = max_columns(bricks);
    long int result = 0;
    int i;
    for (i = 2; i < max_cols; i++) {
        result += ncols(bricks, i, 0);
    }
    return result;
}

int main(int argc, char *argv[]) {
    // int i = readnum(stdin);
    int i = atoi(argv[1]);
    printf("%d\n", solve(i));
}

