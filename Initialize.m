%% Initialize
function [population,best]=Initialize(inputs,outputs,input_numbers) 
global H T GNVARS GSIZE NVARS POPSIZE

population=struct('gene',[],'f',[]);
best=struct('gene',[],'f',[]);
temp=[];

%Type of each position in the chromosome
gene_type_flag=zeros(1,NVARS);
%Head type is set to 0
subgene=zeros(1,H+T);
%Tail type is set to 1
subgene(1,H+1:H+T)=ones(1,T);

for i=1:GSIZE
    gene_type_flag(1, (i-1)*GNVARS+1: i*GNVARS )=subgene;
end

%% 
for i=1:POPSIZE
      for j=1:NVARS
           population(i).gene(j)=Rand_Set_Value(gene_type_flag(j));
      end
      [population(i).f,~]=Evaluate(population(i).gene,inputs,outputs,input_numbers,0);
end

temp=[population.f];
[~,best_index]=min(temp);
best=population(best_index);

%% Select symbols randomly based on the type of each position
function value=Rand_Set_Value(index)
global BASE_FUNCTION_NUM TERMINAL_NUM L_TERMINAL

switch index
    case 0
        if rand(1)<0.5
            value=mod(Set_Rand_Num(),BASE_FUNCTION_NUM);
        else
            value=L_TERMINAL+mod(Set_Rand_Num(),TERMINAL_NUM);
        end
    case 1
             value=L_TERMINAL+mod(Set_Rand_Num(),TERMINAL_NUM);
end
end
%% Generate random integer
function randnum=Set_Rand_Num()
      randnum=round(rand(1)*65535);
end
end