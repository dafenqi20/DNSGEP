%% Translating chromosome into expression tree
function SubRoot=Decode(individual)
global H T GSIZE GNVARS BASE_FUNCTION_NUM L_TERMINAL

SubBinaryTree=struct('node',[],'left_child',[],'right_child',[]);
%The root node of each subtree
SubRoot=struct('root',SubBinaryTree);

for g=1:GSIZE
    %Finding the start of each gene in chromosome
    k=(g-1)*GNVARS;
    
    for i=1:GNVARS
        SubBinaryTree(i).node=individual(k+i);
    end
    %parent node
    op=1;
    %child node
    j=2;
    %Ensure that the gene's starting position is a function
    if SubBinaryTree(1).node<L_TERMINAL
        while(true)
            %If the jth position is a terminal, then op=op+1
            while(op<=GNVARS&&SubBinaryTree(op).node>=L_TERMINAL)
                op=op+1;
                if op>j
                    break;
                end
            end
            if op>j
                break;
            end
            
            if (op<=GNVARS&&SubBinaryTree(op).node<BASE_FUNCTION_NUM)
                if j>H+T
                    break;
                end
                SubBinaryTree(op).left_child=j;
                j=j+1;
                if SubBinaryTree(op).node<4
                    if j>H+T
                        break;
                    end
                    SubBinaryTree(op).right_child=j;
                    j=j+1;
                end
            end
            op=op+1;
        end
    end
    SubRoot(g).root=SubBinaryTree;
    SubBinaryTree=struct('node',[],'left_child',[],'right_child',[]);
end
end