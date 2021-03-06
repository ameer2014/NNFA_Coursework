% % By changing Learning Rate
% Experiment 2

input = data(:,2:10);
output = data(:,11);
Accuracy_file = zeros(1,6);
Error_file = zeros(1,6);
Learning_Rate=0;

for index=1:(5);
    Learning_Rate=Learning_Rate+0.1;
    traindata=input(1:300,:);
    trainoutput=output(1:300,:);

    testdata=input(301:699,:);
    testoutput=output(301:699,:);

    net = newff(traindata',trainoutput',20, {'tansig' 'tansig'}, 'trainr', 'learngd', 'mse');
    net.trainParam.goal = 0.01;
    net.trainParam.epochs = 10;
    net.trainParam.lr=Learning_Rate;
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