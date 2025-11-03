%% Select individuals into the next generation (elite strategy in DE)
function population=Select_Individual(child_population,population)
global POPSIZE

for i=1:POPSIZE
    
    if(child_population(i).f<population(i).f)
        population(i)=child_population(i);
    end
    
end

end