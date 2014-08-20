#include "mex.h"
#include <stdio.h>

static double INF = 100000000000000;

void hello() {
    printf("Hello World\n");
}


void findPath(double* C, double* D, double* idx, int m, int n) {
    int jtemp;

    for (int i=0; i<n; i++) {
        for (int j=0; j<m; j++) {
            D[i*m + j] = 0;
            if (i>0 && j>0) {
                if (D[(i-1)*m + j] < D[(i-1)*m + j-1]) {
                    D[i*m + j] = D[(i-1)*m + j] + C[i * m + j];
                } else {
                    D[i*m + j] = D[(i-1)*m + j-1] + C[i * m + j];
                }
            } else if (i==0 && j==0) {
                D[i*m + j] = C[i * m + j];
            } else if (i==0) {
                D[i*m + j] = INF;
            } else {
                D[i*m + j] = D[(i-1)*m + j] + C[i*m + j];
            }
        }
    }
    
    jtemp = m-1;
    for (int i=n-1; i>=0; i--) {
        idx[i] = jtemp+1;
        idx[n+i] = i+1;

        if (i>0 && jtemp>0) {
            if (D[(i-1)*m + jtemp] < D[(i-1)*m +jtemp-1]) {
                jtemp = jtemp;
            } else {
                jtemp = jtemp - 1;
            }
        } 
    }
}

void mexFunction ( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

    int m=0, n=0;
    double* C;
    double* D;
    double* idx;
            
    if (nrhs>0) {
        m = mxGetM(prhs[0]);
        n = mxGetN(prhs[0]);
        
        C = (double *) mxGetData(prhs[0]);

        plhs[0] = mxCreateDoubleMatrix(m,n, mxREAL);
        D = (double*) mxGetPr(plhs[0]);
        plhs[1] = mxCreateDoubleMatrix(n, 2, mxREAL);
        idx = (double*) mxGetPr(plhs[1]);

        findPath(C, D, idx, m, n);


    } else {

    }

}
