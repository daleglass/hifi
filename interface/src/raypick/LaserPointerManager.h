//
//  LaserPointerManager.h
//  interface/src/raypick
//
//  Created by Sam Gondelman 7/11/2017
//  Copyright 2017 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//
#ifndef hifi_LaserPointerManager_h
#define hifi_LaserPointerManager_h

#include <QHash>
#include <QString>
#include <memory>
#include <glm/glm.hpp>

#include "LaserPointer.h"
#include "DependencyManager.h"

class RayPickResult;

class LaserPointerManager : public Dependency {
    SINGLETON_DEPENDENCY

public:
    unsigned int createLaserPointer(const QVariantMap& rayProps, const QHash<QString, RenderState>& renderStates, const bool faceAvatar, const bool centerEndY,
        const bool lockEnd, const bool enabled);
    void removeLaserPointer(const unsigned int uid);
    void enableLaserPointer(const unsigned int uid);
    void disableLaserPointer(const unsigned int uid);
    void setRenderState(unsigned int uid, const QString& renderState);
    void editRenderState(unsigned int uid, const QString& state, const QVariant& startProps, const QVariant& pathProps, const QVariant& endProps);
    const RayPickResult getPrevRayPickResult(const unsigned int uid);

    void setIgnoreEntities(unsigned int uid, const QScriptValue& ignoreEntities);
    void setIncludeEntities(unsigned int uid, const QScriptValue& includeEntities);
    void setIgnoreOverlays(unsigned int uid, const QScriptValue& ignoreOverlays);
    void setIncludeOverlays(unsigned int uid, const QScriptValue& includeOverlays);
    void setIgnoreAvatars(unsigned int uid, const QScriptValue& ignoreAvatars);
    void setIncludeAvatars(unsigned int uid, const QScriptValue& includeAvatars);

    void update();

private:
    QHash<unsigned int, std::shared_ptr<LaserPointer>> _laserPointers;
    QHash<unsigned int, std::shared_ptr<QReadWriteLock>> _laserPointerLocks;
    unsigned int _nextUID{ 1 }; // 0 is invalid
    QReadWriteLock _addLock;
    QQueue<QPair<unsigned int, std::shared_ptr<LaserPointer>>> _laserPointersToAdd;
    QReadWriteLock _removeLock;
    QQueue<unsigned int> _laserPointersToRemove;
    QReadWriteLock _containsLock;

};

#endif // hifi_LaserPointerManager_h
