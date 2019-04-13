# Introduction
The project is based on the [STRCF](https://github.com/lifeng9472/STRCF).

**The formula of the model update is waiting to be solved.**

# Short how to run

### Using git clone

1. Clone the GIT repository:

   $ git clone https://github.com/GarfieldF/RGBT-tracking  

2. Clone the submodules.  
   In the './external_libs/' directory, run the commands:  
   $ git submodule add https://github.com/pdollar/toolbox  
   $ git submodule add https://github.com/vlfeat/matconvnet  
   $ git submodule init  
   $ git submodule update 

   or in the repository  directory  
   $ git submodule add < url >     ./external_libs/

   and then there will be a new file called '.gitmodules' that stores the mapping between the project’s URL and the local subdirectory.

### Download the RGBT dataset

3. Download the dataset from
https://sites.google.com/view/ahutracking001/Start  , and move it to repository  directory with the original name "RGB-T234"

### Compile the external libs

4. Matlab and navigate to the repository.  
   Run the install script:

   |>> install

### Test whether everything is OK or not  

5. Run the demo script to test the tracker:

   |>> OTBbasketball_STRCF

### Run

6. Run the script to get the result of the whole dataset.   
   |>> run_all_STRCF  
    Each detailed result.mat is saved at './results' and the average value of each sequence is saved at matlab work directory.  

PS:There are two params need to take more attention in run_STRCF.m, i.e., params.RGBT (=1 means use the RGBT-73channel features and =0->RGB-42channel),params.alpha_flag (=1 -> use the weighted modality)
   
