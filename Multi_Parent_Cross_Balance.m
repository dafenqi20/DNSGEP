%% Multi-parent crossover opeartor GEP/balance
function individual_mulCross=Multi_Parent_Cross_Balance(population,individual_f,individual_index,archive_weight,k)
global NVARS

%nbest is the best individual in the neighborhood
%Index of nbest in the neighborhood
[~,nbest_pos]=min(individual_f);
%Index of nbest in the population
nbest_index=individual_index(nbest_pos);
nbest_gene=population(nbest_index).gene;
nbest_weight=archive_weight(nbest_index);

%nworst is the worst individual in the neighborhood
[~,nworst_pos]=max(individual_f);
nworst_index=individual_index(nworst_pos);
nworst_gene=population(nworst_index).gene;
nworst_weight=archive_weight(nworst_index);

[~,col]=size(individual_index);
temp1=individual_index(col);
individual_index(col)=nbest_index;
individual_index(nbest_pos)=temp1;

nworst_pos=find(individual_index==nworst_index,1);
individual_f=individual_index(col-1);
individual_index(col-1)=nworst_index;
individual_index(nworst_pos)=individual_f;

index_rand=randperm(col-2);
x1_pos=index_rand(1);
index_x1=individual_index(x1_pos);
if(index_x1==k)
    x1_pos=index_rand(2);
    index_x1=individual_index(x1_pos);
end
x1_gene=population(index_x1).gene;
x1_weight=archive_weight(index_x1);

weight=[nbest_weight;x1_weight;nworst_weight];
cross_gene=[nbest_gene;x1_gene;nworst_gene];

individual_mulCross=zeros(1,NVARS);

index=Roulette(weight);
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
