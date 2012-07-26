% Verification test using Mahanalobis distance metric
%   Input:
%       MT      -   Distance matrix     Dim x Dim
%       XTNPos1 -   First training data of positive class  nPosTN x Dim
%       XTNPos2 -   Second training data of positive class nPosTN x Dim
%       XTNNeg1 -   First training data of negative class  nNegTN x Dim
%       XTNNeg2 -   Second training data of negative class nNegTN x Dim
%       XTTPos1 -   First test data of positive class  nPosTT x Dim
%       XTTPos2 -   Second test data of positive class nPosTT x Dim
%       XTTNeg1 -   First test data of negative class  nNegTT x Dim
%       XTTNeg2 -   Second test data of negative class nNegTT x Dim
%  Output:
%       CRTT    -   Verification rate          Scalar
%       ROCTT   -   ROC curve nPoints x [FalsePositive, TruePositive] 
% Peng Li 09-02-2011
function [CRTT, ROCTT, DistTTPOS, DistTTNEG, DistTNPOS, DistTNNEG] =...
    verification_ml_test(MT, XTNPos1, XTNPos2, ...
    XTNNeg1, XTNNeg2, XTTPos1, XTTPos2, XTTNeg1, XTTNeg2)

% Calculate the distance between data pairs 
DistTNPOS = (diag((XTNPos1 - XTNPos2) * MT * (XTNPos1 - XTNPos2)'));
DistTNNEG = (diag((XTNNeg1 - XTNNeg2) * MT * (XTNNeg1 - XTNNeg2)'));
DistTTPOS = (diag((XTTPos1 - XTTPos2) * MT * (XTTPos1 - XTTPos2)'));
DistTTNEG = (diag((XTTNeg1 - XTTNeg2) * MT * (XTTNeg1 - XTTNeg2)'));

Threshold = PLDA_Learning_Threshold(-DistTNPOS, -DistTNNEG);
[ROCTT, CRTT] = Verification_Test_Given_Likelihood(...
    -DistTTPOS, -DistTTNEG, Threshold);
end


% Learn a threshold for face verification given test loglikelihood
%  Threshold is the learned threshold
%  BestAVR is the best over all verification rate
%
% Peng Li 02-03-2010
function [Threshold BestAVR]= PLDA_Learning_Threshold...
    (LoglikeRatioPos, LoglikeRatioNeg)

NBins = 6001;

LogLikeAll = [LoglikeRatioPos(:)', LoglikeRatioNeg(:)'];
RMax = max(LogLikeAll);
RMin = min(LogLikeAll);

Step = (RMax - RMin) / NBins;

IndexThreshold = RMin:Step:RMax;

Label = [ones(1, length(LoglikeRatioPos)), zeros(1, length(LoglikeRatioNeg))]';
Predicted = Label;
AVR = zeros(length(IndexThreshold), 1);
for i = 1 : length(IndexThreshold)
    Predicted(find(LogLikeAll >= IndexThreshold(i))) = 1;
    Predicted(find(LogLikeAll < IndexThreshold(i))) = 0;       
    AVR(i) = length(find(Predicted == Label)) / length(Label);
end

[I1, J1] = max(AVR);
if length(J1 == 1)
    Threshold = IndexThreshold(J1(1));
    BestAVR = I1(1);
else
    Threshold = mean(IndexThreshold(J1));
    BestAVR = I1(1);
end
end

% Face verification test given the loglikelihood and a learned threshold
%  CR is the correct verification rate
%
% Peng Li 19-01-2010
function [ROC, CR, PLabel, Label]= Verification_Test_Given_Likelihood(LoglikeRatioPos,...
    LoglikeRatioNeg, Threshold)

NData1 = length(LoglikeRatioPos);
NData2 = length(LoglikeRatioNeg);

% ROC curve
NBins = 6001;
RMax = max([LoglikeRatioPos(:)', LoglikeRatioNeg(:)']);
RMin = min([LoglikeRatioPos(:)', LoglikeRatioNeg(:)']);

Step = (RMax - RMin) / NBins;

IndexThreshold = RMin:Step:RMax;

ROC = zeros(length(IndexThreshold), 2);
for i = 1 : length(IndexThreshold)
    TruePositive = length(find(LoglikeRatioPos > IndexThreshold(i)))...
        ./ length(LoglikeRatioPos);
    FalsePositive = length(find(LoglikeRatioNeg > IndexThreshold(i)))...
        ./ length(LoglikeRatioNeg);
    
    ROC(i, 1) = FalsePositive;
    ROC(i, 2) = TruePositive;
end

if nargout > 1
    LoglikeRatio = ([LoglikeRatioPos(:)', LoglikeRatioNeg(:)']);
    Label = [ones(1, NData1) zeros(1, NData2)]';
    PLabel = zeros(NData1+NData2, 1);
    PLabel(find(LoglikeRatio >= Threshold)) = 1;    
    CR = length(find(PLabel == Label)) / (NData1 + NData2);
end
end