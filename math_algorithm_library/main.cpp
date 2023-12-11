// Jaden Cypes & Kathryn James
// CSI-370: Computer Architecture
// Math Algorithm Library - Sorts & Matrix Operations

// main.cpp

#include <ctime>
#include <cstdlib>
#include <iostream>

using namespace std;

extern "C" void _asmMain();
extern "C" void _matrixAdd();
extern "C" void _matrixMult();
extern "C" void _matrixMultiplication();

/* By receiving a matrix and its corresponding title, this function outputs 
the resulting matrix to the console by properly displaying its rows/columns.
Rather than the 2D array appearing as one long string of numbers, this
function formats the matrix and its values accordingly for improved 
visualization (Kathryn James). */
extern "C" void _printMatrix(int matrix[3][3], char* str) {
	int i, j, k, n = 3;

	cout << endl << str << endl;
	for (i = 0; i < n; ++i)
		for (j = 0; j < n; ++j)
		{
			cout << " " << matrix[i][j];
			if (j == n - 1)
				cout << endl;
		}
	return;
}

/* This function randomly generates a 2D array (a square matrix) to be used
for the matrix operations. It takes no arguments, but randomly generates the
values in the matrix based on the programmer-defined size (Kathryn James). */
extern "C" int** _getMatrix() {
	int N = 3, random;
	int** arr = new int* [N];
	srand(time(0));

	for (int i = 0; i < N; ++i) {
		arr[i] = new int[N];
		for (int j = 0; j < N; ++j) {
			random = 1 + (rand() % 10);  // generate random numbers between 1-10
			arr[i][j] = random;
			cout << arr[i][j] << endl;
		}
	}
	return arr;
}

/*

*/
int main() {
	cout << "MATRIX ADDITION" << endl;
	_matrixAdd();
	cout << "\n--------------------\nMATRIX MULTIPLICATION" << endl;
	_matrixMultiplication();
	
	return 0;
}