%% Update CR
function [population,memory_cr,memory_pos]=Update_CR(child_population,population,memory_cr,memory_pos,memory_size,cr)

parent_fitness=[population.f];
child_fitness=[child_population.f];
%Index of individuals Ui that are better than the parent individuals Xi
index_children_better=(parent_fitness>child_fitness);
good_CR=cr(index_children_better);

dif=abs(parent_fitness-child_fitness);
dif_val=dif(index_children_better);
num_success_parans=numel(good_CR);

if(num_success_parans>0)
    
    sum_dif=sum(dif_val);
    dif_val=dif_val/sum_dif;
    
    if max(good_CR) == 0 || memory_cr(memory_pos)  == -1
        memory_cr(memory_pos)  = -1;
    else
        %Updating the CR in memory
         memory_cr(memory_pos) = (dif_val * (good_CR .^ 2)) / (dif_val * good_CR);
    end
    
    memory_pos=memory_pos+1;
    
    if(memory_pos>memory_size)
        memory_pos=1;
    end
    
end

end