# Discrete function

## Problem statement

There is a discrete function. It is specified for integer arguments from 1 to N
(2 ≤ N ≤ 100000). Each value of the function is longint (signed long in C++).
You have to find such two points of the function for which all points between
them are below than straight line connecting them and inclination of this
straight line is the largest.

**Input**

There is an N in the first line. Than N lines follow with the values of the
function for the arguments 1, 2, …, N respectively.

**Output**

A pair of integers, which are abscissas of the desired points, should be
written into one line of output. The first number must be less then the second
one. If it is any ambiguity your program should write the pair with the
smallest first number.

## Sample

**Input**

    3
    2
    6
    4

**Output**

    1 2

## References

http://acm.timus.ru/problem.aspx?num=1010

