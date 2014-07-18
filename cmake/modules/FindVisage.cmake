# 
#  FindVisage.cmake
# 
#  Try to find the Visage controller library
#
#  You must provide a VISAGE_ROOT_DIR which contains lib and include directories
#
#  Once done this will define
#
#  VISAGE_FOUND - system found Visage
#  VISAGE_INCLUDE_DIRS - the Visage include directory
#  VISAGE_LIBRARIES - Link this to use Visage
#
#  Created on 2/11/2014 by Andrzej Kapolka
#  Copyright 2014 High Fidelity, Inc.
#
#  Distributed under the Apache License, Version 2.0.
#  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
# 

set(VISAGE_SEARCH_DIRS "${VISAGE_ROOT_DIR}" "$ENV{VISAGE_ROOT_DIR}" "$ENV{HIFI_LIB_DIR}/visage")

find_path(VISAGE_INCLUDE_DIR VisageTracker2.h ${VISAGE_ROOT_DIR}/include)

if (APPLE)
  find_path(VISAGE_XML_INCLUDE_DIR libxml/xmlreader.h HINTS ${VISAGE_SEARCH_DIRS} /usr/include/libxml2)
  find_path(VISAGE_OPENCV_INCLUDE_DIR cv.h PATH_SUFFIXES dependencies/OpenCV_MacOSX/include HINTS ${VISAGE_SEARCH_DIRS})
  find_path(VISAGE_OPENCV2_INCLUDE_DIR opencv.hpp PATH_SUFFIXES dependencies/OpenCV_MacOSX/include/opencv2 HINTS ${VISAGE_SEARCH_DIRS})
  
  find_library(VISAGE_CORE_LIBRARY NAME vscore PATH_SUFFIXES lib HINTS ${VISAGE_SEARCH_DIRS})
  find_library(VISAGE_VISION_LIBRARY NAME vsvision PATH_SUFFIXES lib HINTS ${VISAGE_SEARCH_DIRS})
  find_library(VISAGE_OPENCV_LIBRARY NAME OpenCV PATH_SUFFIXES dependencies/OpenCV_MacOSX/lib ${VISAGE_SEARCH_DIRS})
  
elseif (WIN32)
  find_path(VISAGE_XML_INCLUDE_DIR libxml/xmlreader.h PATH_SUFFIXES dependencies/libxml2/include HINTS ${VISAGE_SEARCH_DIRS})
  find_path(VISAGE_OPENCV_INCLUDE_DIR opencv/cv.h PATH_SUFFIXES dependencies/OpenCV/include HINTS ${VISAGE_SEARCH_DIRS})
  find_path(VISAGE_OPENCV2_INCLUDE_DIR cv.h PATH_SUFFIXES dependencies/OpenCV/include/opencv HINTS ${VISAGE_SEARCH_DIRS})
  
  find_library(VISAGE_CORE_LIBRARY NAME vscore PATH_SUFFIXES lib HINTS ${VISAGE_SEARCH_DIRS})
  find_library(VISAGE_VISION_LIBRARY NAME vsvision PATH_SUFFIXES lib HINTS ${VISAGE_SEARCH_DIRS})
  find_library(VISAGE_OPENCV_LIBRARY NAME opencv_core243 PATH_SUFFIXES dependencies/OpenCV/lib HINTS ${VISAGE_SEARCH_DIRS})
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(VISAGE DEFAULT_MSG 
  VISAGE_INCLUDE_DIR VISAGE_XML_INCLUDE_DIR VISAGE_OPENCV_INCLUDE_DIR VISAGE_OPENCV2_INCLUDE_DIR
  VISAGE_CORE_LIBRARY VISAGE_VISION_LIBRARY VISAGE_OPENCV_LIBRARY
)

set(VISAGE_INCLUDE_DIRS "${VISAGE_XML_INCLUDE_DIR}" "${VISAGE_OPENCV_INCLUDE_DIR}" "${VISAGE_OPENCV2_INCLUDE_DIR}")
set(VISAGE_LIBRARIES "${VISAGE_CORE_LIBRARY}" "${VISAGE_VISION_LIBRARY}" "${VISAGE_OPENCV_LIBRARY}")

mark_as_advanced(
  VISAGE_INCLUDE_DIRS VISAGE_LIBRARIES
  VISAGE_INCLUDE_DIR VISAGE_XML_INCLUDE_DIR VISAGE_OPENCV_INCLUDE_DIR VISAGE_OPENCV2_INCLUDE_DIR
  VISAGE_CORE_LIBRARY VISAGE_VISION_LIBRARY VISAGE_OPENCV_LIBRARY
)
