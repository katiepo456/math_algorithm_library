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

/*

*/
extern "C" void _printMatrix(int matrix[3][3], char* str) {
	int i, j, k, r1 = 3, c2 = 3;

	cout << endl << str << endl;
	for (i = 0; i < r1; ++i)
		for (j = 0; j < c2; ++j)
		{
			cout << " " << matrix[i][j];
			if (j == c2 - 1)
				cout << endl;
		}
	return;
}

/*

*/
extern "C" int** _getMatrix() {
	//int N = 2 + (rand() % 10);		// possibly randomize size of the square matrix?
	int N = 3, random;
	int** arr = new int* [N];
	srand(time(0));

	for (int i = 0; i < N; ++i) {
		arr[i] = new int[N];
		for (int j = 0; j < N; ++j) {
			random = 1 + (rand() % 10);
			arr[i][j] = random;
			cout << arr[i][j] << endl;
		}
	}
	return arr;
}

/*

*/
int main() {
	_asmMain();
	
	return 0;
}