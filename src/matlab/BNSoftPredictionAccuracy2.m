function marg = BNSoftPredictionAccuracy2(netobj, posteriornodes)

% from strings to integers
predictionNodes = cellfun(@(x) BNWhichNode(netobj,x), posteriornodes);

marg = marginal_nodes(netobj.engine, predictionNodes);