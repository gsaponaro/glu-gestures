/*
 * Copyright: (C) 2015 VisLab, Institute for Systems and Robotics,
 *                     Istituto Superior Técnico, Lisbon, Portugal
 * Author: Giovanni Saponaro
 * CopyPolicy: Released under the terms of the GNU GPL v2.0
 */

#ifndef GESTURE_H
#define GESTURE_H

#include <iostream>
#include <string>

#include <yarp/os/BufferedPort.h>
#include <yarp/os/Log.h>
#include <yarp/os/Network.h>
#include <yarp/os/RateThread.h>
#include <yarp/os/RFModule.h>

/* RateThread class */

class GestureThread : public yarp::os::RateThread
{
public:
    GestureThread(unsigned int _period);
    ~GestureThread();
    bool threadInit();
    void run();
    void threadRelease();
};

/* RFModule class */

class GestureModule : public yarp::os::RFModule
{
private:
    //GestureThread *thr;

    yarp::os::BufferedPort<yarp::os::Bottle> inSkelPort;
    
    yarp::os::BufferedPort<yarp::os::Bottle> outHandPort;

public:
    bool configure(yarp::os::ResourceFinder &rf);
    bool interruptModule();
    bool close();

    double getPeriod();
    bool updateModule();
};

#endif // __GESTURE_H__
