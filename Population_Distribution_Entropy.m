%% Population distribution entropy
function diversity=Population_Distribution_Entropy(population)
global H BASE_FUNCTION_NUM TERMINAL_NUM L_TERMINAL POPSIZE

symbol_digit=ceil(log(POPSIZE)/log(BASE_FUNCTION_NUM+TERMINAL_NUM));
if(symbol_digit>H)
    display('The symbol number exceeds the header length');
end

subspace=zeros(1,POPSIZE);
for i=1:POPSIZE
    %Several positions are weighted to obtain a positive integer, and each positive integer represents a subspace
    for j=1:symbol_digit
        subspace(i)=subspace(i)*10+population(i).gene(j);
    end
end

%Finding individuals with the terminal as the first position in the population
index=subspace>=L_TERMINAL*(10^(symbol_digit-1));

%These individuals with the terminal as the first position have the same expression tree
%so they can be considered to be in the same subspace
subspace(index)=L_TERMINAL*10^(symbol_digit-1);

different_subspaces=unique(subspace);

%Counting the number of subspaces
subspaces_num=length(different_subspaces);

individuals_in_subspace=zeros(size(different_subspaces));

%Counting the number of individuals in each subspace
for i=1:subspaces_num
    individuals_in_subspace(i)=length(find(subspace==different_subspaces(i)));
end

individuals_in_subspace=individuals_in_subspace/POPSIZE;
diversity=sum(individuals_in_subspace.*log(individuals_in_subspace));
diversity=-diversity;

end