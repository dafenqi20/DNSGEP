%% DE crosss
function individual_cross=DE_Cross(individual_mutation,individual,CR)
global NVARS

individual_cross=ones(1,NVARS);
%A randomly selected bit must be crossed
k=randperm(NVARS,1);
%Selecting the bits for crossover randomly
index_cross=rand(1,NVARS)<repmat(CR,1,NVARS);
index_cross(k)=1;
%cross
individual_cross(index_cross)=individual_mutation(index_cross);
individual_cross(~index_cross)=individual(~index_cross);

end