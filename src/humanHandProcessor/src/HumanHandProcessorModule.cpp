/*
 * Copyright: (C) 2017 VisLab, Institute for Systems and Robotics,
 *                     Istituto Superior Técnico, Lisbon, Portugal
 * Author: Giovanni Saponaro
 * CopyPolicy: Released under the terms of the GNU GPL v2.0
 */

#include "HumanHandProcessorModule.h"

using namespace std;
using namespace yarp::os;

bool HumanHandProcessorModule::configure(ResourceFinder &rf)
{
    string moduleName;
    moduleName = rf.check( "name",Value("humanHandProcessor") ).asString();
    setName(moduleName.c_str());
    
    inSkelPort.open(("/"+moduleName+"/skel:i").c_str());
    outHandPort.open(("/"+moduleName+"/hand:o").c_str());
    
    return true;
}

bool HumanHandProcessorModule::interruptModule()
{
    inSkelPort.interrupt();
    outHandPort.interrupt();
    return true;
}


bool HumanHandProcessorModule::close()
{
    inSkelPort.close();
    outHandPort.close();
    return true;
}

bool HumanHandProcessorModule::updateModule()
{
    const int expSkelSize = 91;
    Bottle *skel = inSkelPort.read(true);
    if (skel != NULL)
    {
        if (skel->size() != expSkelSize)
        {
            yWarning("skeleton bottle size mismatch");
            return true;
        }

        Bottle &b = outHandPort.prepare();
        b.clear();

        const int rightHandJointIdx = 8;
        const int jointSize = 6;

        b.addDouble(skel->get(1+rightHandJointIdx*jointSize+1).asList()->get(0).asDouble());
        b.addDouble(skel->get(1+rightHandJointIdx*jointSize+1).asList()->get(1).asDouble());
        b.addDouble(skel->get(1+rightHandJointIdx*jointSize+1).asList()->get(2).asDouble());

        outHandPort.write();
    }

    return true;
}

double HumanHandProcessorModule::getPeriod()
{
    return 0.0; // sync with incoming data
}
