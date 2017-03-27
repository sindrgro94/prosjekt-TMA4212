# prosjekt-TMA4212
- To get a demonstration, run the script "demonstration.m" and navigate in the menu. 
- All the solvers use solveWave.m to call the correct solver with correct parameters.
- Be aware that the "percent finished countdown" is in each solver, which means it will
    go two times up to 100 percent in "numerical VS anlytic" and in the "dam break demonstration".
- To make errorplots one first have to make a reference matrix in makeRefMatrices.m,
    after this the errorplotFromReference.m can run when the method name has been edited.
- The rest of the functions that are not mentioned are either used in solveWave.m or
    demonstration.m. It is possible to run solveWave with other inital values than
    what is set in demonstration.m. See the comment block in the beginning of the function
    to get an explanation of the variables in solveWave.m.