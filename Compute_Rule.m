%% Calculate the fitness value based on the expression tree
function current_value_sum=Compute_Rule(SubRoot,inputs,input_numbers)
global CONNECTOR GSIZE 

current_value=zeros(input_numbers,GSIZE);
for i=1:GSIZE
    SubTree=SubRoot(i).root;
    current_value(:,i)=INOrderTraverse(SubTree,SubTree(1),inputs,input_numbers);
end
switch CONNECTOR
    case 0
        %Connect subtrees by '+'
        current_value_sum=sum(current_value,2);
    case 1
        %Connect subtrees by '*'
        current_value_sum=Connect(current_value,input_numbers);
end
end
%% Calculate the value of the subtree translated from the ith gene in the chromosome
function current_value=INOrderTraverse(SubTree,Node,inputs,input_numbers)
global L_TERMINAL

%End if it's a leaf node
if Node.node >= L_TERMINAL
    current_value = inputs(:,Node.node - L_TERMINAL+1);
else
    if ~isempty(Node.left_child)
        current_value=INOrderTraverse(SubTree,SubTree(Node.left_child),inputs,input_numbers);
    end
    t1 = current_value;
    %If node is '+', '-', '*', '/'
    if Node.node < 4
        if ~isempty(Node.right_child)
            current_value=INOrderTraverse(SubTree,SubTree(Node.right_child),inputs,input_numbers);
        end
        t2 = current_value;
    end
    switch Node.node
        case 0 % + 			
            current_value = t1 + t2;
		case 1 % -
            current_value = t1 - t2;
		case 2 % *
            current_value = t1 .* t2;
		case 3 % /
            index=abs(t2)<1e-20;
            current_value=zeros(input_numbers,1);
            current_value(~index)=t1(~index)./t2(~index);
		case 4 % sin
            current_value = sin(t1);
		case 5 % cos
            current_value = cos(t1);
		case 6 % exp
            index=t1<20;
            current_value=zeros(input_numbers,1);
            current_value(index)=exp(t1(index));
            current_value(~index)=repmat(exp(20.),sum(~index),1);
		case 7 % log
            index=abs(t1)<1e-20;
            current_value=zeros(input_numbers,1);
            current_value(~index)=log(abs(t1(~index)));
    end
end
end
%% Connect subtrees by '*'
function currnet_value_sum=Connect(current_value,input_numbers)
global GSIZE

currnet_value_sum=ones(input_numbers,1);

for i=1:input_numbers
    for j=1:GSIZE
        current_value_sum(i,1)=current_value_sum(i,1)*current_value(i,j);
    end
end

end
