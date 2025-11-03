function [best,evaluation]=DNSGEP(inputs,outputs,input_numbers,terminal_numbers)
% <algorithm><M>
% DNSGEP

% This is a simple demo of DNSGEP
%--------------------------------------------------------------------------------------------------------
% If you find this code useful in your work, please cite the 
%following paper"Peng H*, Li L (Student), Mei C (Student), Deng C, Yue X, Wu Z. 
%                           Gene expression programming with dual strategies and neighborhood search 
%                           for symbolic regression problems[J]. Applied Soft Computing, 2023.
%--------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------
% More information can visit Hu Peng's homepage: https://whuph.github.io/index.html
%--------------------------------------------------------------------------------------------------------
%% Some basic parameters of GEP
global H T  NVARS BASE_FUNCTION_NUM GSIZE L_TERMINAL  TERMINAL_NUM GNVARS CONNECTOR MAX_GENERATIONS MAX_EVALUATIONS POPSIZE
%% Parameters of DNSGEP
global PM MAX_NEIGHBORHOOD_SIZE MIN_NEIGHBORHOOD_SIZE DIVERSITY_THRESHOLD
%% Setting parameter
H=20;               
T=H+1;
%Length of the gene
GNVARS=H+T;
%The number of genes in the chromosome
GSIZE=1;
%Length of the chromosome
NVARS=GSIZE*GNVARS;
L_TERMINAL=10000;
BASE_FUNCTION_NUM=8;
TERMINAL_NUM=terminal_numbers;
%0 means add, 1 means multiply
CONNECTOR=0;
PM=0.03;
DIVERSITY_THRESHOLD=0.4;
%Minimum value of neighborhood size
MIN_NEIGHBORHOOD_SIZE=2;
POPSIZE=100;
%Maximum value of neighborhood size
MAX_NEIGHBORHOOD_SIZE=floor((POPSIZE-1)/2);
MAX_EVALUATIONS=20000;
MAX_GENERATIONS=200;

%% Initialize
evaluation=0;
generation=1;
memory_size=NVARS;
memory_cr=0.5*ones(memory_size,1);
%pointer to memory
memory_pos=1;
%The initial value of the selection weights for each individual is '1/popsize'
archive_weight=ones(1,POPSIZE)/POPSIZE;
%The initial value of the neighborhood radius for each individual is the smallest neighborhood radius
neighborhood_size=MIN_NEIGHBORHOOD_SIZE*ones(POPSIZE,1);

[population,best]=Initialize(inputs,outputs,input_numbers);
%% Generation
while(generation<=MAX_GENERATIONS&&evaluation<MAX_EVALUATIONS)
    
    entropy_diversity=Population_Distribution_Entropy(population);
    archive_weight=Selection_Weight(population);
    cr=Select_CR(memory_size,memory_cr);
    child_population=...
        Evolution(population,cr,neighborhood_size,archive_weight,entropy_diversity);
 
     for i=1:POPSIZE
         [child_population(i).f,evaluation]=...
             Evaluate(child_population(i).gene,inputs,outputs,input_numbers,evaluation);
     end
     
     [population,memory_cr,memory_pos]=...
         Update_CR(child_population,population,memory_cr,memory_pos,memory_size,cr);
     population=Select_Individual(child_population,population);
     
     temp_f=[population.f];
     [best_value,index_best]=min(temp_f);
     if(best_value<best.f)
         best.gene=population(index_best).gene;
         best.f=population(index_best).f;
     end
     
     %Updating the index of individuals in the next generation of populations
     population=Update_Index(population);
     
     if(best.f<1e-2)
         break;
     end
     
    generation=generation+1;
    
end
end
