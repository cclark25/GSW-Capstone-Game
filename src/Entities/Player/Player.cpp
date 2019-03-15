#include "Player.h"
#include <string>
#include <InputEvent.hpp>

using namespace godot;

void Player::_register_methods() {
    register_method((char *)"_process", &Player::_process);
    register_method((char *)"_init", &Player::_init);
    register_method((char *)"_input", &Player::_input);
    register_method((char *)"TakeDamage", &Player::TakeDamage);
//    register_method((char *)"SayHello", &gdexample::hello);
}

Player::Player() {
    // initialize any variables here
    time_passed = 0.0;
}

Player::~Player() {
    // add your cleanup here
}

void Player::_input(InputEvent event){
	Godot::print("Input method called.");
}

void Player::TakeDamage(int amount, Vector2 source){
	Godot::print("Damage received!");
}

void Player::_init() {
	owner->set_process(false);
	owner->set_name("PlayerNode");
	//Godot::print(owner->get_child(0)->get_name());
	//Godot::print("Hello World!");
}

void Player::_process(float delta) {
    time_passed += delta;
    owner->set_process(false);

    Vector2 new_position = Vector2(120.0 + (10.0 * sin(time_passed * 2.0)), 20.0 + (10.0 * cos(time_passed * 1.5)));
    //Godot::print(std::to_string(owner->get_child_count()).c_str());
    
    owner->set_position(new_position);
}
