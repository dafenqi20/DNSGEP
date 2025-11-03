%% Select CR
function cr=Select_CR(memory_size,memory_cr)
global POPSIZE

%Each individual was randomly selected Mcr
rand_index=ceil(memory_size*rand(POPSIZE,1));
mu_cr=memory_cr(rand_index);
%Each individual selects a random number from the corresponding normal distribution.
cr=normrnd(mu_cr,0.1);
term_pos = mu_cr == -1;
cr(term_pos) = 0;
%cr is limited to between 0 and 1
cr=min(cr,1);
cr=max(cr,0);
end