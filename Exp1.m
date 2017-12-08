% By changing data for tainning and testing
% Experiment 1

input = data(:,2:10);
output = data(:,11);
Accuracy_file = zeros(1,6);
Error_file = zeros(1,6);
first=0;

for index=1:(6);
    first=first+300;
    second=first+1;
    traindata=input(1:first,:);
    trainoutput=output(1:first,:);

    testdata=input(second:699,:);
    testoutput=output(second:699,:);

    net = newff(traindata',trainoutput',20, {'tansig' 'tansig'}, 'trainr', 'learngd', 'mse');
    net.trainParam.goal = 0.01;
    net.trainParam.epochs = 10;
    net.trainParam.lr=0.1;
    net.trainparam.max_fail = 100;
    net = train(net, traindata',trainoutput');

    result = net(testdata');

    error=0;
    for i=1:size(result,2)
         if ((result(i)>2.5 || result(i)<1.5) && testoutput(i)==2) || ((result(i)<3.5 || result(i)>4.5) && testoutput(i)==4)
            error=error+1;
         end;

    end;
    percentsge_error = (error/size(result,2))*100;
    percentage_accuracy = ((size(result,2)-error)/size(result,2))*100;
    
     Error_file(index)=percentsge_error;
     Accuracy_file(index)=percentage_accuracy;
        
end;

