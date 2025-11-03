%% 
function individual_weight=Selection_Weight(population)
global POPSIZE

temp_f1=[population.f];
temp_f1=temp_f1';

temp_f1=repmat(temp_f1,1,POPSIZE);
temp_f2=temp_f1';

difference_f=abs(temp_f1-temp_f2);

max_difference_f=max(difference_f);
max_difference_f=max(max_difference_f);
min_difference_f=min(difference_f);
min_difference_f=min(min_difference_f);
difference_f=(difference_f-min_difference_f)/(max_difference_f-min_difference_f);

sum_difference_f=sum(difference_f,2);
sum_f=sum(sum_difference_f);

individual_weight=sum_difference_f/sum_f;

end