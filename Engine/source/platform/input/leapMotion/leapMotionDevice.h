// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

#ifndef _LEAPMOTIONDEVICE_H_
#define _LEAPMOTIONDEVICE_H_

#include "platform/input/IInputDevice.h"
#include "platform/input/event.h"
#include "platformWin32/platformWin32.h"
#include "core/util/tSingleton.h"
#include "math/mQuat.h"
#include "platform/input/leapMotion/leapMotionConstants.h"
#include "Leap.h"

#define DEFAULT_MOTION_UNIT 0

struct LeapMotionDeviceData;

class LeapMotionDevice : public IInputDevice
{
protected:
   class MotionListener : public Leap::Listener
   {
   public:
      MotionListener() {}
      virtual ~MotionListener() {}

      virtual void onConnect (const Leap::Controller &controller);
      virtual void onDisconnect (const Leap::Controller &controller);
   };

   /// The connection to the Leap Motion
   Leap::Controller* mController;

   /// Our Leap Motion listener class
   MotionListener* mListener;

   /// Used with the LM listener object
   void* mActiveMutex;

   /// Is the Leap Motion active
   bool mActive;

   /// Buffer to store data Leap Motion data in a Torque friendly way
   LeapMotionDeviceData*  mDataBuffer[2];

   /// Points to the buffers that holds the previously collected data
   LeapMotionDeviceData*  mPrevData;

protected:
   /// Build out the codes used for controller actions with the
   /// Input Event Manager
   void buildCodeTable();

public:
   static bool smEnableDevice;

   // Indicates that events for each hand and pointable will be created
   static bool smGenerateIndividualEvents;

   // Indicates that we track hand IDs and will ensure that the same hand
   // will remain at the same index between frames.
   static bool smKeepHandIndexPersistent;

   // Indicates that we track pointable IDs and will ensure that the same
   // pointable will remain at the same index between frames.
   static bool smKeepPointableIndexPersistent;

   // Broadcast single hand rotation as axis
   static bool smGenerateSingleHandRotationAsAxisEvents;

   // The maximum hand angle when used as an axis event
   // as measured from a vector pointing straight up (in degrees)
   static F32 smMaximumHandAxisAngle;

   // Indicates that a whole frame event should be generated and frames
   // should be buffered.
   static bool smGenerateWholeFrameEvents;

   // Frame action codes
   static U32 LM_FRAMEVALIDDATA;    // SI_BUTTON

   // Hand action codes
   static U32 LM_HAND[LeapMotionConstants::MaxHands];    // SI_POS
   static U32 LM_HANDROT[LeapMotionConstants::MaxHands]; // SI_ROT

   static U32 LM_HANDAXISX;   // SI_AXIS
   static U32 LM_HANDAXISY;

   // Pointables action codes
   static U32 LM_HANDPOINTABLE[LeapMotionConstants::MaxHands][LeapMotionConstants::MaxPointablesPerHand];    // SI_POS
   static U32 LM_HANDPOINTABLEROT[LeapMotionConstants::MaxHands][LeapMotionConstants::MaxPointablesPerHand]; // SI_ROT

   // Whole frame
   static U32 LM_FRAME;    // SI_INT

public:
   LeapMotionDevice();
   ~LeapMotionDevice();

   static void staticInit();

   bool enable();
   void disable();

   bool getActive();
   void setActive(bool state);

   bool process();

public:
   // For ManagedSingleton.
   static const char* getSingletonName() { return "LeapMotionDevice"; }   
};

/// Returns the LeapMotionDevice singleton.
#define LEAPMOTIONDEV ManagedSingleton<LeapMotionDevice>::instance()

#endif   // _LEAPMOTIONDEVICE_H_
