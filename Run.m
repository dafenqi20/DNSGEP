path='./symbolic regression dataset1/';
file=dir(path); 
file=file(3:end);
%Number of test problems
file_numbers=length(file);
max_run_times=10;
results=struct('function',[],'success',[],'RMSE',[]);
%Save the function evaluations for all problems
evaluations=struct('evaluation',[]);

for i=1:file_numbers
    %Path to the file where the test data is stored
    fpath=fullfile(path,file(i).name);
    fid = fopen(fpath);
    row_column=fscanf(fid,'%f',2);
    rows=row_column(1);
    columns=row_column(2)+1;
    data=fscanf(fid,'%f',[columns rows]);
    data=data';
    input_numbers=rows;
    %Inputs for all test data
    inputs=data(:,1:columns-1);
    %Outputs for all test data
    outputs=data(:,columns);
    fclose('all');
    terminal_numbers=columns-1;
    results(i).function=file(i).name;
    results(i).success=0;
    evaluation_data=zeros(1,max_run_times);
   %All runs of a test problem
     for run_time=1:max_run_times
        [best,evaluation]=DNSGEP(inputs,outputs,input_numbers,terminal_numbers);
        %Save the number of function evaluations for all runs of a problem
        evaluation_data(run_time)=evaluation;
        if best.f<1e-2
            results(i).success=results(i).success+1;
        end
        results(i).RMSE(run_time)=best.f;
        fprintf(sprintf('%srun time%d, best£º%d\n',file(i).name,run_time,best.f));
     end
     
     evaluations(i).evaluation=evaluation_data;
end