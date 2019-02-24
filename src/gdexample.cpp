#include "gdexample.h"

using namespace godot;

void gdexample::_register_methods() {
    register_method((char *)"_process", &gdexample::_process);
//    register_method((char *)"SayHello", &gdexample::hello);
}

gdexample::gdexample() {
    // initialize any variables here
    time_passed = 0.0;
}

gdexample::~gdexample() {
    // add your cleanup here
}

//void hello(){
//	Godot::print("Hello World!");
//}

void gdexample::_process(float delta) {
    time_passed += delta;
    Godot::print("Hello World!");

    Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

    owner->set_position(new_position);
}
