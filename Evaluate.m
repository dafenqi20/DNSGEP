%% Calculate individual fitness values
function [v,evaluation]=Evaluate(individual,inputs,outputs,input_numbers,evaluation)
SubRoot=Decode(individual);
current_value_sum=Compute_Rule(SubRoot,inputs,input_numbers);
%RMSE
v=sum((outputs-current_value_sum).^2);
v=sqrt(v/input_numbers);
evaluation=evaluation+1;
end