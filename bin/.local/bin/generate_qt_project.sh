#!/bin/bash

# Script to create a basic Qt Quick project

# Check if a project name was given
if [ -z "$1" ]; then
    echo "Usage: $0 <ProjectName>"
    exit 1
fi

PROJECT_NAME=$1

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1

# Create .pro file
cat > CMakeLists.txt <<EOL
cmake_minimum_required(VERSION 3.16)

project($PROJECT_NAME VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(\${PROJECT_NAME}
    main.cpp
)

qt_add_qml_module(\${PROJECT_NAME}
    URI QML${PROJECT_NAME}
    VERSION 1.0
    QML_FILES Main.qml
)

target_link_libraries(\${PROJECT_NAME}
    PRIVATE Qt6::Quick
)
EOL

# Create main.cpp
cat > main.cpp <<EOL
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/QML${PROJECT_NAME}/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
EOL

# Create Main.qml
mkdir -p qml
cat > Main.qml <<EOL
import QtQuick 
import QtQuick.Window 

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello Qt Quick!")

    Rectangle {
        anchors.fill: parent
        color: "lightblue"

        Text {
            anchors.centerIn: parent
            text: "Hello, World!"
            font.pointSize: 24
        }
    }
}
EOL

echo "Qt Quick project '$PROJECT_NAME' created successfully."
