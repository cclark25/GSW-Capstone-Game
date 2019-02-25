#include "gdexample.h"
#include "GlobalResources.h"
#include <string>

using namespace godot;

void gdexample::_register_methods() {
    register_method((char *)"_process", &gdexample::_process);
//    register_method((char *)"SayHello", &gdexample::hello);
}

gdexample::gdexample() {
    // initialize any variables here
    time_passed = 0.0;
    SpriteList.insert(this);
    Godot::print("New sprite inserted into SpriteList. Sprite count is now: ");
    Godot::print(std::to_string(SpriteList.size()).c_str());
}

gdexample::~gdexample() {
    // add your cleanup here
    SpriteList.erase(this);
    Godot::print("Sprite removed from SpriteList. Sprite count is now: ");
    Godot::print(std::to_string(SpriteList.size()).c_str());
}

//void hello(){
//	Godot::print("Hello World!");
//}

void gdexample::_process(float delta) {
    time_passed += delta;
    if(time_passed > 3){

	   owner->get_parent()->add_child(new Sprite(), true);
	   //owner->queue_free(); 
    }

    Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

    owner->set_position(new_position);
}
