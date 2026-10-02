module raylib;

alias Color = char[<4>];
alias Vector2 = float[<2>];

struct ColorStruct {
    char r;
    char g;
    char b;
    char a;
}

extern fn void init_window(int width, int height, char *title) @cname("InitWindow");
extern fn void close_window() @cname("CloseWindow");
extern fn void set_target_fps(int fps) @cname("SetTargetFPS");
extern fn bool window_should_close() @cname("WindowShouldClose");
extern fn void begin_drawing() @cname("BeginDrawing");
extern fn void clear_background(char[4] color) @cname("ClearBackground");
extern fn void end_drawing() @cname("EndDrawing");
extern fn void draw_rectangle(int posX, int posY, int width, int height, Color color) @cname("DrawRectangle");
extern fn float get_frame_time() @cname("GetFrameTime");
extern fn void draw_rectangle_v(float[2] position, float[2] size, char[4] color) @cname("DrawRectangleV");
extern fn int get_screen_width() @cname("GetScreenWidth");
extern fn int get_screen_height() @cname("GetScreenHeight");
extern fn Color color_from_hsv(float hue, float saturation, float value) @cname("ColorFromHSV");
extern fn int get_random_value(int min, int max) @cname("GetRandomValue");
