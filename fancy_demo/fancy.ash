// fancy module header
// by eri0o

// internal abstraction
managed struct TextToken {
  int text_begin, text_length, color, font, type, width, height, line_height, line_width, box_width;
};

#define FANCY_INFINITE_WIDTH 65536

// ----------------------------------------------------------------------
// ---------------- fancy module public interface -----------------------
// ----------------------------------------------------------------------

/// Draw the text parsing fancyness
import void DrawFancyTextWrapped(this DrawingSurface*, int x, int y, int width, int color, FontType font, const string text);

managed struct FancyDrawingConfig {
  int Font, TextColor, LineSpacing, TextAlign;
  /// Create minimal fancy drawing configuration
  static import FancyDrawingConfig* Create(FontType font, int color, Alignment align = eAlignBottomLeft, int line_spacing = 0); 
};

struct FancyTextBase {  
  /// Setup text arrangement and display parameters
  import void SetDrawingConfig(FancyDrawingConfig* config);
  
  /// Set drawing limits
  import void SetDrawingArea(int x, int y, int width = FANCY_INFINITE_WIDTH);
  
  /// Sets the text of the fancy text box
  import void SetFancyText(String text);
  
  /// Draw Text in surface area
  import void Draw(DrawingSurface* surf);
  
  // internal things
  protected String _text;
  protected TextToken* _tk_arr[];
  protected int _tk_count;
  protected FancyDrawingConfig* _cfg;
  protected int _x;
  protected int _y;
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

