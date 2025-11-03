%% Evolution
function [child_population]=Evolution(population,cr,neighborhood_size,archive_weight,entropy_diversity)
global POPSIZE DIVERSITY_THRESHOLD

child_population=struct('gene',[],'f',[]);
temp_f=[population.f];
temp_f=temp_f';

for k=1:POPSIZE
    %% Divide the neighborhood of each individual
    individual=population(k).gene;
    individual_f=temp_f(k);
    individual_index=k;
    
    %If the minimum index within the neighborhood of an individual is less than 1
    if k-neighborhood_size(k)<=0
        
        %Find the index of the leftmost individual in the left half neighborhood of the individual
        index_left=mod(POPSIZE+k-neighborhood_size(k),POPSIZE+1);
        
        %Index of the unexceeded portion
        index_isNotOver=1:k-1;
        individual_f=[temp_f(1:k-1);individual_f];
        %Index of the exceeded portion
        index_isOver=index_left:POPSIZE;
        individual_f=[temp_f(index_left:end);individual_f];
        
        individual_index=[index_isOver,index_isNotOver,individual_index];
        
    else
        
        individual_f=[temp_f(k-neighborhood_size(k):k-1);individual_f];
        individual_index=[k-neighborhood_size(k):k-1,individual_index];
        
    end
    
    %If the maximum index within the neighborhood of an individual is greater than popsize
    if k+neighborhood_size(k)>POPSIZE
        
        %Find the index of the rightmost individual in the right half neighborhood of the individual
        index_right=mod(POPSIZE+k+neighborhood_size(k),POPSIZE);
        
        %Index of the unexceeded portion
        index_isNotOver=k+1:POPSIZE;
        individual_f=[individual_f;temp_f(k+1:end)];
        %Index of the exceeded portion
        index_isOver=1:index_right;
        individual_f=[individual_f;temp_f(1:index_right)];
        
        individual_index=[individual_index,index_isNotOver,index_isOver];
        
    else
        
        individual_f=[individual_f;temp_f(k+1:k+neighborhood_size(k))];
        individual_index=[individual_index,k+1:k+neighborhood_size(k)];
        
    end
    %% Generate individual Ui
    if(entropy_diversity>DIVERSITY_THRESHOLD)
        individual_mulCross=Multi_Parent_Cross_Rand(population,individual_index,archive_weight);
    else
        individual_mulCross=Multi_Parent_Cross_Balance(population,individual_f,individual_index,archive_weight,k);
    end
    individual_mutation=Mutation(individual_mulCross);
    individual_cross=DE_Cross(individual_mutation,population(k).gene,cr(k));
    child_population(k).gene=individual_cross;
    
end
end