% GLU 2017, compute the marginal probability of specified posterior node(s)
% Giovanni Saponaro

% Note:
% the name of this function is not intuitive, but it was chosen to be
% similar to BNSoftPredictionAccuracy (actually to the first part of that
% function, the one that computes the predictions).

function marg = BNSoftPredictionAccuracy2(netobj, posteriornodes)

% from strings to integers
predictionNodes = cellfun(@(x) BNWhichNode(netobj,x), posteriornodes);

marg = marginal_nodes(netobj.engine, predictionNodes);