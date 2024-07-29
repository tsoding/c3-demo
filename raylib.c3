module raylib;

def Color = char[<4>];
def Vector2 = float[<2>];

struct ColorStruct {
    char r;
    char g;
    char b;
    char a;
}

extern fn void init_window(int width, int height, char *title) @extern("InitWindow");
extern fn void close_window() @extern("CloseWindow");
extern fn void set_target_fps(int fps) @extern("SetTargetFPS");
extern fn bool window_should_close() @extern("WindowShouldClose");
extern fn void begin_drawing() @extern("BeginDrawing");
extern fn void clear_background(char[4] color) @extern("ClearBackground");
extern fn void end_drawing() @extern("EndDrawing");
extern fn void draw_rectangle(int posX, int posY, int width, int height, Color color) @extern("DrawRectangle");
extern fn float get_frame_time() @extern("GetFrameTime");
extern fn void draw_rectangle_v(float[2] position, float[2] size, char[4] color) @extern("DrawRectangleV");
extern fn int get_screen_width() @extern("GetScreenWidth");
extern fn int get_screen_height() @extern("GetScreenHeight");
extern fn Color color_from_hsv(float hue, float saturation, float value) @extern("ColorFromHSV");
extern fn int get_random_value(int min, int max) @extern("GetRandomValue");
