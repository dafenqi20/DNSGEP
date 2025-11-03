%% Mutation
function individual_mutation=Mutation(individual)
global PM NVARS

individual_mutation=individual;
index = rand(1,NVARS)<repmat(PM,1,NVARS); 
individual_temp=Mutation_individual();
%Selection of the sign bit where the mutation occurs according to the index
individual_mutation(index)=individual_temp(index);

end
%% Generate a chromosome where every bit is mutated
function individual_temp=Mutation_individual()
global H T GSIZE  BASE_FUNCTION_NUM TERMINAL_NUM L_TERMINAL

mutation_gene_H=zeros(1,H);
individual_temp=[];

for i=1:GSIZE
    index_H=rand(1,H)<repmat(0.5,1,H);
    %Head can be mutated into functions or terminals
    temp1=mod(Set_Rand_Num(1,H),BASE_FUNCTION_NUM);
    %The flag is 1, then the bit mutates to a function
    mutation_gene_H(index_H)=temp1(index_H);
    temp2=L_TERMINAL*ones(1,H)+mod(Set_Rand_Num(1,H),TERMINAL_NUM);
    %The flag is 0, then the bit mutates to a terminal
    mutation_gene_H(~index_H)=temp2(~index_H);
    
    mutation_gene_T=L_TERMINAL*ones(1,T)+mod(Set_Rand_Num(1,T),TERMINAL_NUM);
    
    mutation_gene=[mutation_gene_H,mutation_gene_T];
    %Merge each gene
    individual_temp=[individual_temp,mutation_gene];
end

end
%% Generate random integer
function randnum=Set_Rand_Num(row,col)
      randnum=round(rand(row,col)*65535);
end