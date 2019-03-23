#ifndef PLAYER_DEF
#define PLAYER_DEF

#include <Godot.hpp>
#include <Vector2.hpp>
#include <KinematicBody2D.hpp>
#include <InputEvent.hpp>

namespace godot {

class Player : public GodotScript<KinematicBody2D> {
    GODOT_CLASS(Player)

private:
    float time_passed;

public:
    static void _register_methods();

    Player();
    ~Player();

    void TakeDamage(int amount, Vector2 position);

    void _init();
    void _input(InputEvent event);
    void _process(float delta);
};

}

#endif

