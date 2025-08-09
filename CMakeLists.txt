cmake_minimum_required(VERSION 3.16)

project(IotAppSensors VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)

message(STATUS "Using Qt version: ${Qt6Core_VERSION}")

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appIotAppSensors
    main.cpp
)

qt_add_qml_module(appIotAppSensors
    URI IotAppSensors
    VERSION 1.0
    QML_FILES Main.qml
    SOURCES HumiditySensor.h HumiditySensor.cpp
    SOURCES TemperatureSensor.h TemperatureSensor.cpp
    RESOURCES
    RESOURCES icons/bxs_home.png
    RESOURCES
    RESOURCES
    RESOURCES icons/material-symbols_settings.png
    RESOURCES icons/signal_icon.svg
    RESOURCES icons/temperature.png icons/humidity.png
    RESOURCES fonts/Inter_28pt-Light.ttf
    QML_FILES HumidityPage.qml
    QML_FILES TemperaturePage.qml
)

set_target_properties(appIotAppSensors PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appIotAppSensors PRIVATE Qt6::Core Qt6::Quick)
target_link_libraries(appIotAppSensors PRIVATE Qt6::Core)
target_link_libraries(appIotAppSensors PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appIotAppSensors
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
