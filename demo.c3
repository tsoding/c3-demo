// ./c3c compile --reloc=none --target wasm32 -g0 --link-libc=no --use-stdlib=no --no-entry -o web web.c3
import raylib;

def Entry = fn void();

extern fn void raylib_js_set_entry(Entry entry) @wasm;

Object[20] objects;

const Vector2 PLAYER_SIZE = {100, 100};
const Vector2 GRAVITY = {0, 1000};
const int N = 10;
const float COLLISION_DAMP = 1;

struct Object {
    Vector2 position;
    Vector2 velocity;
    Color color;
}

fn void Object.randomize(Object *obj) {
    obj.position = {
        // TODO: Casting to int is wrong. It would be better to have
        // an RNG that generates floats 0..1 in the first place.
        raylib::get_random_value(0, raylib::get_screen_width() - (int)PLAYER_SIZE.x),
        raylib::get_random_value(0, raylib::get_screen_height() - (int)PLAYER_SIZE.y)
    };
    obj.velocity = {200, 200};
    obj.color = raylib::color_from_hsv(360*((float)raylib::get_random_value(0, 100)/100.0), 1, 1);
}

fn void game_frame() @wasm
{
    float dt = raylib::get_frame_time();
    raylib::begin_drawing();
        raylib::clear_background({0x18, 0x18, 0x18, 0xFF});
        foreach (&object: objects) {
            object.velocity += GRAVITY*dt;
            float nx = object.position.x + object.velocity.x*dt;
            if (nx < 0 || nx + PLAYER_SIZE.x > raylib::get_screen_width()) {
                object.velocity.x *= -COLLISION_DAMP;
                object.color = raylib::color_from_hsv(360*((float)raylib::get_random_value(0, 100)/100.0), 1, 1);
            } else {
                object.position.x = nx;
            }
            float ny = object.position.y + object.velocity.y*dt;
            if (ny < 0 || ny + PLAYER_SIZE.y > raylib::get_screen_height()) {
                object.velocity.y *= -COLLISION_DAMP;
                object.color = raylib::color_from_hsv(360*((float)raylib::get_random_value(0, 100)/100.0), 1, 1);
            } else {
                object.position.y = ny;
            }

            raylib::draw_rectangle_v(object.position, PLAYER_SIZE, object.color);
        }
    raylib::end_drawing();
}

fn void main() @extern("main") @wasm
{
    raylib::init_window(800, 600, "Hello, from C3 WebAssembly");
    raylib::set_target_fps(60);

    foreach (&object: objects) {
        object.randomize();
    }
    
    $if $feature(PLATFORM_WEB):
        raylib_js_set_entry(&game_frame);
    $else
        while (!raylib::window_should_close()) {
            game_frame();
        }
        raylib::close_window();
    $endif
}
