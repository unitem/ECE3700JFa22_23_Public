#include<iostream>

using namespace std;

#define size 20

int isPos(int x) {
	if (x > 0) return 1;
	else return 0;
}

int isNeg(int x) {
	if (x < 0) return 1;
	else return 0;
}

int isZero(int x) {
	if (x == 0) return 1;
	else return 0;
}

int sumArray(int A[], int numElements) {
	int temp = 0;
	for (int i = 0; i < numElements; i++) {
		temp += A[i];
	}
	return temp;
}

int countArray(int A[], int numElements, int cntType) {
	int cnt = 0;
	for (int i = 0; i < numElements; i++) {
		if (cntType == 1 && isPos(A[i]) == 1)
			cnt++;
		else if (cntType == -1 && isNeg(A[i]) == 1)
			cnt++;
		else if (cntType == 0 && isZero(A[i]) == 1)
			cnt++;
	}
	return cnt;	
}

int main() {
	//int size = 20;
	int PosCnt, NegCnt, ZeroCnt, Sum;
	int testArray[size] = { 1, 20,3,-4,0,-1,2,4,1,0,1,-2,3,5,1,0,-1,-2,-100,23 };
	PosCnt = countArray(testArray, size, 1);
	NegCnt = countArray(testArray, size, -1);
	ZeroCnt = countArray(testArray, size, 0);
	Sum = sumArray(testArray, size);
	cout << PosCnt << NegCnt << ZeroCnt << Sum;
}