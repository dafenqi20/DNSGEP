%% Multi-parent crossover opeartor GEP/rand
function individual_mulCross=Multi_Parent_Cross_Rand(population,individual_index,archive_weight)
global NVARS

[~,col]=size(individual_index);
individual_pos=ceil(col/2);

index_rand=randperm(col);
x1_pos=index_rand(1);
x2_pos=index_rand(2);
x3_pos=index_rand(3);
if(x1_pos==individual_pos)
    x1_pos=index_rand(4);
end
if(x2_pos==individual_pos)
    x2_pos=index_rand(4);
end
if(x3_pos==individual_pos)
    x3_pos=index_rand(4);
end

x1_index=individual_index(x1_pos);
x1=population(x1_index).gene;
x1_weight=archive_weight(x1_index);

x2_index=individual_index(x2_pos);
x2=population(x2_index).gene;
x2_weight=archive_weight(x2_index);

x3_index=individual_index(x3_pos);
x3=population(x3_index).gene;
x3_weight=archive_weight(x3_index);

weight=[x1_weight;x2_weight;x3_weight];
cross_gene=[x1;x2;x3];

individual_mulCross=zeros(1,NVARS);

index=Roulette(weight);
%Three parent individuals to cross
%so the index is limited to between 1 and 3
index=min(index,3);
index=max(index,1);
for i=1:NVARS
    
    individual_mulCross(i)=cross_gene(index(i),i);
    
end

end
%% Roulette
function index=Roulette(weight)
global NVARS

sum_weight=sum(weight);
pd=weight/sum_weight;
probability=cumsum(pd);

index=ones(1,NVARS);
for i=1:NVARS
    p=rand(1);
    for j=1:3
        if(p<probability(j))
            index(i)=j;
            break;
        end
    end
end

end