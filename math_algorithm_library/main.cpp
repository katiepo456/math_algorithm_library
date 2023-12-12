#include <iostream>
#include <vector>
#include <random>
using namespace std;

//extern "C" void asmBubbleSort(vector<int> vec, int vecSize); if the array passed from C++ would work
extern "C" void asmBubbleSort();
extern "C" void asmSelectionSort();
extern "C" void asmInsertionSort();

extern "C" void _printNum(int arr[10]) {
	for (int i = 0; i < 10; i++) {
		cout << " " << arr[i];
	}
	cout << endl;
}

int main() {
	// create the random device engine
	random_device rd;
	mt19937 rng(rd());
	uniform_int_distribution<int> dist(1, 100);

	// create the array
	vector<int> vec;

	// declare size of vecotr and fill it with numbers
	const int vectorSize = 100;
	for (int i = 0; i < vectorSize; ++i) {
		int randNum = dist(rng);
		vec.push_back(randNum);
	}
	//for (int num : vec) {  // To see the array before it was sorted
		// cout << num << " ";
	//}
	
	asmBubbleSort();
	asmSelectionSort();
	asmInsertionSort();
	
	return 0;
}