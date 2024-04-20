// fancy module header
// by eri0o
// Version 0.6.0

// internal abstraction
managed struct FancyTextToken {
  int color, outline_color; short text_begin, text_length, font, type, width, height, line_height, line_width;
};

managed struct FancyState {
  int X, Y, BoxWidth, BoxHeight;
};

#define FANCY_INFINITE_WIDTH 65536

// ----------------------------------------------------------------------
// ---------------- fancy module public interface -----------------------
// ----------------------------------------------------------------------


managed struct FancyConfig {
  FontType Font;
  Alignment TextAlign;
  int TextColor, OutlineColor, OutlineWidth, LineSpacing, Padding;
  /// Create minimal fancy drawing configuration
  static import FancyConfig* Create(FontType font = 0, int color = 65535, int outline_color = COLOR_TRANSPARENT, int outline_width = 1, Alignment align = eAlignBottomLeft, int line_spacing = 0); // $AUTOCOMPLETESTATICONLY$
  
  // internal
  import void Set(FancyConfig* config); // $AUTOCOMPLETEIGNORE$  
  import FancyConfig* Clone(); // $AUTOCOMPLETEIGNORE$  
};

managed struct Fancy9Piece {
  int T, B, L, R, TL, TR, BL, BR, CBG; // $AUTOCOMPLETEIGNORE$
  int T_w, T_h, B_w,  B_h, L_w, L_h, R_w, R_h, TL_w, TL_h, TR_w, TR_h, BL_w, BL_h, BR_w, BR_h, CBG_w, CBG_h, CBG_Color; // $AUTOCOMPLETEIGNORE$
  int BorderTop, BorderBottom, BorderLeft, BorderRight; // $AUTOCOMPLETEIGNORE$
  import void Set(int top , int bottom, int left, int right, int top_left, int top_right, int bottom_left, int bottom_right, int center_piece = 0, int bg_color = 0); // $AUTOCOMPLETEIGNORE$
  /// Create a 9 piece fancy compatible from a Text Window GUI
  static import Fancy9Piece* CreateFromTextWindowGui(GUI* text_window_gui); // $AUTOCOMPLETESTATICONLY$
  /// Create a 9 piece fancy from 9 sprite slots
  static import Fancy9Piece* CreateFrom9Sprites(int top , int bottom, int left, int right, int top_left, int top_right, int bottom_left, int bottom_right, int center_piece = 0, int bg_color = 0); // $AUTOCOMPLETESTATICONLY$
};

/// Draw the text from a fancy string
import void DrawFancyString(this DrawingSurface*, int x, int y, const string text, FancyConfig* config = 0, int width = FANCY_INFINITE_WIDTH);

/// Create a sprite with the text of a fancy string
import DynamicSprite* CreateFromFancyString(static DynamicSprite, const string text, FancyConfig* config = 0, int width = FANCY_INFINITE_WIDTH);

/// Create a sprite of a textbox with a fancy string using a 9-piece
import DynamicSprite* CreateFromFancyTextBox(static DynamicSprite, const string text, FancyConfig* config = 0, int width = FANCY_INFINITE_WIDTH, Fancy9Piece* f9p = 0);

/// Creates a screen overlay from a textbox with a fancy string using a 9-piece
import Overlay* CreateFancyTextBox(static Overlay, int x, int y, const string text, FancyConfig* config = 0, int width = FANCY_INFINITE_WIDTH, Fancy9Piece* f9p = 0);

/// Sets a button NormalGraphic and additional sprites from it's text, assumed as fancy string, and 9-piece.
import void Fancify(this Button*, Fancy9Piece* normal = 0, Fancy9Piece* mouse_over = 0, Fancy9Piece* pushed = 0);

/// Removes fancyness from button (clear any altered sprites)
import void UnFancify(this Button*);

builtin managed struct Fancy {
  /// allows adding a global alias to a tag-value. Ex: AddAlias("red", 63488) allows using [c:red] instead of [c:63488].
  import static void AddAlias(String key, int value);
  /// Global default text arrangement and display parameters
  import static attribute FancyConfig* FancyConfig;
#ifndef SCRIPT_EXT_AGS4
  import static FancyConfig* get_FancyConfig(); // $AUTOCOMPLETEIGNORE$
  import static void set_FancyConfig(FancyConfig* value); // $AUTOCOMPLETEIGNORE$
#endif
};

struct FancyTextBase {
  /// Set drawing limits
  import void SetDrawingArea(int x, int y, int width = FANCY_INFINITE_WIDTH);  
  /// Sets the text of the fancy text box
  import void SetFancyText(String text);  
  /// Draw Text in surface area
  import void Draw(DrawingSurface* surf);
  /// Setup text arrangement and display parameters
  import attribute FancyConfig* FancyConfig;
#ifndef SCRIPT_EXT_AGS4
  import FancyConfig* get_FancyConfig(); // $AUTOCOMPLETEIGNORE$
  import void set_FancyConfig(FancyConfig* value); // $AUTOCOMPLETEIGNORE$
#endif
  
  // internal things
  protected String _text;
  protected FancyTextToken* _tk_arr[];
  protected FancyState* _fs;
  protected int _tk_count;
  protected FancyConfig* _cfg;
  protected int _width;
};

struct FancyTypedText extends FancyTextBase {
  /// Clears all text and resets all timers
  import void Clear();
  /// Sets new string, resets all timers and commences typing
  import void Start(String text);
  /// Skips all the remaining typing
  import void Skip();
  /// Update typed text state, advancing it by single tick
  import void Tick();
  /// Draw typed text state, advancing it by single tick
  import void DrawTyped(DrawingSurface* surf);
  
  // internal
  protected int _typed_token_count;
  protected int _typed_token_len;  
};

