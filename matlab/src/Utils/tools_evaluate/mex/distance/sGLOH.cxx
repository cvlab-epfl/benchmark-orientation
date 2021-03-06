#include <math.h>

double computeDistance(const double* feat1,const double* feat2,const int f1, const int f2,const int size)
{
	int nbBins = 8;

	double descd = 0;
	unsigned int index [] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127};
	const unsigned int nextindex [] = {
		// The inner ring
		56,57,58,59,60,61,62,63,
		0,1,2,3,4,5,6,7,
		8,9,10,11,12,13,14,15,
		16,17,18,19,20,21,22,23,
		24,25,26,27,28,29,30,31,
		32,33,34,35,36,37,38,39,
		40,41,42,43,44,45,46,47,
		48,49,50,51,52,53,54,55,
		// The outher ring
		120,121,122,123,124,125,126,127,
		64,65,66,67,68,69,70,71,
		72,73,74,75,76,77,78,79,
		80,81,82,83,84,85,86,87,
		88,89,90,91,92,93,94,95,
		96,97,98,99,100,101,102,103,
		104,105,106,107,108,109,110,111,
		112,113,114,115,116,117,118,119
	};

	double mindescd = 1e10;
	for (int idxShift = 0;idxShift < nbBins;idxShift++)
	{
        descd=0;
        for(int v=0;v<size-9;v++){//distance is computed here !!!!
			descd+=fabs(feat1[f1+index[v]+9]-feat2[f2+v+9]);
			index[v] = nextindex[index[v]];
        }
		
        if (mindescd > descd)
			mindescd = descd;
	}
	descd =  mindescd;

	return descd;
}