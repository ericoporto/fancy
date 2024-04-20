# fancy

[![build-and-test-windows](https://github.com/ericoporto/fancy/actions/workflows/main.yml/badge.svg)](https://github.com/ericoporto/fancy/actions)

Fancy is a Script module for "fancy" text in Adventure Game Studio.

With Fancy you can have text with multiple colors, fonts, with sprites and other. It brings it's own Typed-Text mechanism and additional fancyness.

The cheatsheet of tags are below. Some tags are "solo", they don't require a closing tag.

- Color tag is `"[c:123]"` and `"[/c]"`, where `"123"` is an ags color for the text.
- Outline color tag is `"[o:123]"` and `"[/o]"`, where `"123"` is an ags color for the outline.
- Font tag is `"[f:123]"` and `"[/f]"`, where `"123"` is an ags font index.
- Sprite tag is solo `"[s:123]`, where `"123"` is an ags sprite.

Note: use `"\n"` for linefeed, old lone `"["` ags linefeed is not supported.

Notice that if you need to pass a number that is dynamic you can use String.Format to create the string with the proper number, like if the sprite icon you want to put in your text is from a dynamic sprite or the color of a word comes from a character speech color.

![](https://i.imgur.com/w5olTxGl.png)

## Usage

I will improve this soon, for now some small examples

*Using a regular drawing surface:*

```AGS Script
function room_AfterFadeIn()
{
  Fancy.AddAlias("red", 64493); // this should be at game_start

  DrawingSurface* surf = Room.GetDrawingSurfaceForBackground();

  surf.DrawingColor = 10565;
  surf.DrawRectangle(48, 48, 248, 108);
  surf.DrawFancyString(48, 48, "Hello!\n[o:8560]Can you find me the [c:27647]blue cup [s:2041][/c][/o]?\nI lost it in the [c:red]dangerous [f:0]planet[/f][/c], somewhere.", FancyConfig.Create(eFontSpeech, 22422), 200);
}
```

*Simple not-useful typed text example:*

```AGS Script
FancyTypedText fttb; // has to be global

function room_AfterFadeIn()
{
  Fancy.AddAlias("red", 64493); // this should be at game_start
  Fancy.AddAlias("ico_bcup", 2041); // this should be at game_start

  fttb.FancyConfig.Font = eFontSpeech;
  fttb.FancyConfig.TextColor = 22422;
  fttb.SetDrawingArea(48, 48, 200);
  fttb.Start("Hello!\n[o:8560]Can you find me the [c:27647]blue cup [s:ico_bcup][/c][/o]?\nI lost it in the [c:red]dangerous [f:0]planet[/f][/c], somewhere.");
}

void repeatedly_execute_always()
{
  DrawingSurface* surf = Room.GetDrawingSurfaceForBackground();

  surf.DrawingColor = 10565;
  surf.DrawRectangle(48, 48, 248, 108);

  fttb.Tick();
  fttb.DrawTyped(surf);
}
```

---

## Script API

### Script Extensions

#### `DrawingSurface.DrawFancyString`
```AGS Script
void DrawingSurface.DrawFancyString(int x, int y, const string text, optional FancyConfig* config, optional int width);
```
Draw the text from a fancy string on the drawing surface.

#### `DynamicSprite.CreateFromFancyString`
```AGS Script
DynamicSprite* DynamicSprite.CreateFromFancyString(const string text, optional FancyConfig* config, optional width);
```
Create a sprite with the text of a fancy string

#### `DynamicSprite.CreateFromFancyTextBox`
```AGS Script
DynamicSprite* DynamicSprite.CreateFromFancyTextBox(const string text, optional FancyConfig* config, optional width, optional Fancy9Piece* f9p);
```
Create a sprite of a textbox with a fancy string using a 9-piece.

#### `Overlay.CreateFancyTextBox`
```AGS Script
Overlay* Overlay.CreateFancyTextBox(int x, int y, const string text, optional FancyConfig* config, optional int width, optional Fancy9Piece* f9p );
```
Creates a screen overlay from a textbox with a fancy string using a 9-piece

#### `Button.Fancify`
```AGS Script
void Button.Fancify(optional Fancy9Piece* normal, optional Fancy9Piece* mouse_over, optional Fancy9Piece* pushed);
```
Sets a button NormalGraphic and additional sprites from its text, assumed as fancy string, and 9-piece.

#### `Button.UnFancify`
```AGS Script
void Button.UnFancify();
```
Removes fanciness from button (clear any altered sprites)


### Fancy

This is a global struct you can't instantiate, it contains static methods for global configuration meant to be used at game start.

#### `Fancy.AddAlias`
```AGS Script
static void Fancy.AddAlias(String key, int value);
```

Allows adding a global alias to a tag-value. Ex: AddAlias("red", 63488) allows using [c:red] instead of [c:63488].

This may be useful if you want to be able to change your mind later on what is the specific of a color, or you want to have an easier type remembering sprite icons you are reusing in your texts.

Alias added here are global to all of Fancy. It's recommended that you only add an alias once to everything you need at the game_start of your project, make it easier to manage aliases.

#### `Fancy.FancyConfig`
```AGS Script
static attribute FancyConfig* Fancy.FancyConfig;
```

This is the default global FancyConfig, if you don't specify or if you pass null to a method that requires a FancyConfig as parameter it will use this config instead.


### Fancy9Piece

This is a managed struct that holds a 9-piece that can be used for drawing text boxes.

#### `Fancy9Piece.CreateFromTextWindowGui`
```AGS Script
static Fancy9Piece* Fancy9Piece.CreateFromTextWindowGui(GUI* text_window_gui);
```
Create a 9 piece fancy compatible from a Text Window GUI.

#### `Fancy9Piece.CreateFrom9Sprites`
```AGS Script
static Fancy9Piece* Fancy9Piece.CreateFrom9Sprites(int top , int bottom, int left, int right, int top_left, int top_right, int bottom_left, int bottom_right, int center_piece = 0, int bg_color = 

0);
```
Create a 9 piece fancy from 9 sprite slots.

You can optionally pass a color instead of a sprite for the center piece, by passing 0 to center_piece and a valid AGS color in bg_color.


### FancyConfig

This is a managed struct meant to configure an instance from FancyTextBase and extensions, prefer using its Create method.

#### `FancyConfig.Create`
```AGS Script
static FancyConfig* FancyConfig.Create(FontType font, int color, int outline_color, int outline_width, Alignment align, int line_spacing);
```
Configuration structure for fancy text drawing, allowing customization of font, text color, line spacing, and alignment.
By default, when using create, if you don't set, outline color is initially set for `COLOR_TRANSPARENT` and outline width is initially set to 1, align is set to eAlignBottomLeft and line_spacing is 0.


### FancyTextBase

#### `FancyTextBase.SetDrawingArea`
```AGS Script
void FancyTextBase.SetDrawingArea(int x, int y, int width = FANCY_INFINITE_WIDTH);
```
Sets the area for drawing fancy text, specifying the position and width.

#### `FancyTextBase.SetFancyText`
```AGS Script
void FancyTextBase.SetFancyText(String text);
```
Sets the text content for the fancy text, this is where the parsing of the text happens.

#### `FancyTextBase.Draw`
```AGS Script
void FancyTextBase.Draw(DrawingSurface* surf);
```
Draws the fancy text on the specified drawing surface.

#### `FancyTextBase.FancyConfig`
```AGS Script
attribute FancyConfig* FancyTextBase.FancyConfig;
```
Property to set the Fancy Text rendering configuration.


### FancyTypedText

#### `FancyTypedText.Clear`
```AGS Script
void FancyTypedText.Clear();
```
Clears all text and resets everything for typed text.

#### `FancyTypedText.Start`
```AGS Script
void FancyTypedText.Start(String text);
```
Sets a new string and resets everything to start typing. You can then use Tick repeatedly to advance the text.

#### `FancyTypedText.Skip`
```AGS Script
void FancyTypedText.Skip();
```
Skips all remaining typing of the text.

#### `FancyTypedText.Tick`
```AGS Script
void FancyTypedText.Tick();
```
Updates the typed text state, advancing it by a single tick.

#### `FancyTypedText.DrawTyped`
```AGS Script
void FancyTypedText.DrawTyped(DrawingSurface* surf);
```
Draws the typed text in its current state.


## License

This module is created by eri0o is provided with MIT License, see [LICENSE](https://github.com/ericoporto/fancy/blob/main/LICENSE) for more details.
