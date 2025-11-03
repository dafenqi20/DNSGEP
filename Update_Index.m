%% Update the index of all individuals
function population=Update_Index(population)
global POPSIZE

population_temp=struct('gene',[],'f',[]);
%Generate a sequence of random numbers equal to the size of the population
%individuals in the next generation of the population update the index according to this sequence
next_location=randperm(POPSIZE);
for i=1:POPSIZE
    population_temp(i).gene=population(next_location(i)).gene;
    population_temp(i).f=population(next_location(i)).f;
end

for j=1:POPSIZE
    population(j).gene=population_temp(j).gene;
    population(j).f=population_temp(j).f;
end

end