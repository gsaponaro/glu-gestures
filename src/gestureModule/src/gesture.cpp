/*
 * Copyright: (C) 2015 VisLab, Institute for Systems and Robotics,
 *                     Istituto Superior Técnico, Lisbon, Portugal
 * Author: Giovanni Saponaro
 * CopyPolicy: Released under the terms of the GNU GPL v2.0
 */

#include "gesture.h"

using namespace std;
using namespace yarp::os;

/* RateThread class */

GestureThread::GestureThread(unsigned int _period)
: RateThread(_period)
{
}

GestureThread::~GestureThread()
{
}

bool GestureThread::threadInit()
{
    return true;
}

void GestureThread::run()
{

}

void GestureThread::threadRelease()
{

}

/* RFModule class */

bool GestureModule::configure(ResourceFinder &rf)
{
    string moduleName;
    moduleName = rf.check( "name",Value("gesture") ).asString();
    setName(moduleName.c_str());
    
    inSkelPort.open(("/"+moduleName+"/skel:i").c_str());
    outHandPort.open(("/"+moduleName+"/hand:o").c_str());
    
    return true;
}

bool GestureModule::interruptModule()
{
    inSkelPort.interrupt();
    outHandPort.interrupt();
    return true;
}


bool GestureModule::close()
{
    inSkelPort.close();
    outHandPort.close();
    return true;
}

bool GestureModule::updateModule()
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

double GestureModule::getPeriod()
{
    return 0.0; // sync with incoming data
}
