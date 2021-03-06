// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

#include "platform/platform.h"
#include "gfx/gl/gfxGLVertexBuffer.h"

#include "gfx/gl/gfxGLDevice.h"
#include "gfx/gl/gfxGLEnumTranslate.h"
#include "gfx/gl/gfxGLUtils.h"
#include "gfx/gl/gfxGLVertexAttribLocation.h"


GFXGLVertexBuffer::GFXGLVertexBuffer(  GFXDevice *device, 
                                       U32 numVerts, 
                                       const GFXVertexFormat *vertexFormat, 
                                       U32 vertexSize, 
                                       GFXBufferType bufferType )
   :  GFXVertexBuffer( device, numVerts, vertexFormat, vertexSize, bufferType ), 
      mZombieCache(NULL),
      mFrameAllocatorMark(0),
      mFrameAllocatorPtr(NULL)
{
   // Generate a buffer
   glGenBuffers(1, &mBuffer);

   //and allocate the needed memory
   PRESERVE_VERTEX_BUFFER();
   glBindBuffer(GL_ARRAY_BUFFER, mBuffer);
   glBufferData(GL_ARRAY_BUFFER, numVerts * vertexSize, NULL, GFXGLBufferType[bufferType]);
}

GFXGLVertexBuffer::~GFXGLVertexBuffer()
{
	// While heavy handed, this does delete the buffer and frees the associated memory.
   glDeleteBuffers(1, &mBuffer);

   if( mZombieCache )
      delete [] mZombieCache;
}

void GFXGLVertexBuffer::lock( U32 vertexStart, U32 vertexEnd, void **vertexPtr )
{
   PROFILE_SCOPE(GFXGLVertexBuffer_lock);

   AssertFatal(!mFrameAllocatorMark && !mFrameAllocatorPtr, "");
   mFrameAllocatorMark = FrameAllocator::getWaterMark();
   mFrameAllocatorPtr = (U8*)FrameAllocator::alloc( mNumVerts * mVertexSize );
#if TORQUE_DEBUG
   mFrameAllocatorMarkGuard = FrameAllocator::getWaterMark();
#endif

   lockedVertexPtr = (void*)(mFrameAllocatorPtr + (vertexStart * mVertexSize));
   *vertexPtr = lockedVertexPtr;

	lockedVertexStart = vertexStart;
	lockedVertexEnd   = vertexEnd;
}

void GFXGLVertexBuffer::unlock()
{
   PROFILE_SCOPE(GFXGLVertexBuffer_unlock);

   U32 offset = lockedVertexStart * mVertexSize;
   U32 length = (lockedVertexEnd - lockedVertexStart) * mVertexSize;
   
   PRESERVE_VERTEX_BUFFER();
   glBindBuffer(GL_ARRAY_BUFFER, mBuffer);
   
   if( !lockedVertexStart && lockedVertexEnd == mNumVerts)
      glBufferData(GL_ARRAY_BUFFER, mNumVerts * mVertexSize, NULL, GFXGLBufferType[mBufferType]); // orphan the buffer

   glBufferSubData(GL_ARRAY_BUFFER, offset, length, mFrameAllocatorPtr + offset );

   lockedVertexStart = 0;
	lockedVertexEnd   = 0;
   lockedVertexPtr = NULL;

#if TORQUE_DEBUG
   AssertFatal(mFrameAllocatorMarkGuard == FrameAllocator::getWaterMark(), "");
#endif
   FrameAllocator::setWaterMark(mFrameAllocatorMark);
   mFrameAllocatorMark = 0;
   mFrameAllocatorPtr = NULL;
}

void GFXGLVertexBuffer::prepare()
{
   AssertFatal(0, "GFXGLVertexBuffer::prepare - use GFXGLVertexBuffer::prepare(U32 stream, U32 divisor)");
}

void GFXGLVertexBuffer::prepare(U32 stream, U32 divisor)
{
   if( gglHasExtension(ARB_vertex_attrib_binding) )
   {      
      glBindVertexBuffer( stream, mBuffer, 0, mVertexSize );
      glVertexBindingDivisor( stream, divisor );
      return;
   }
}

void GFXGLVertexBuffer::finish()
{
   
}

GLvoid* GFXGLVertexBuffer::getBuffer()
{
	// NULL specifies no offset into the hardware buffer
	return (GLvoid*)NULL;
}

void GFXGLVertexBuffer::zombify()
{
   if(mZombieCache || !mBuffer)
      return;
      
   mZombieCache = new U8[mNumVerts * mVertexSize];
   glBindBuffer(GL_ARRAY_BUFFER, mBuffer);
   glGetBufferSubData(GL_ARRAY_BUFFER, 0, mNumVerts * mVertexSize, mZombieCache);
   glBindBuffer(GL_ARRAY_BUFFER, 0);
   glDeleteBuffers(1, &mBuffer);
   mBuffer = 0;
}

void GFXGLVertexBuffer::resurrect()
{
   if(!mZombieCache)
      return;
   
   glGenBuffers(1, &mBuffer);
   glBindBuffer(GL_ARRAY_BUFFER, mBuffer);
   glBufferData(GL_ARRAY_BUFFER, mNumVerts * mVertexSize, mZombieCache, GFXGLBufferType[mBufferType]);
   glBindBuffer(GL_ARRAY_BUFFER, 0);
   
   delete[] mZombieCache;
   mZombieCache = NULL;
}
