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

![](https://i.imgur.com/w5olTxGl.png)

## Usage

I will improve this soon, for now some small examples

*Using a regular drawing surface:*

```AGS Script
function room_AfterFadeIn()
{
  DrawingSurface* surf = Room.GetDrawingSurfaceForBackground();
  
  surf.DrawingColor = 10565;
  surf.DrawRectangle(48, 48, 248, 108);
  surf.DrawFancyTextWrapped(48, 48, 200, 22422, eFontSpeech, "Hello!\n[o:8560]Can you find me the [c:27647]blue cup [s:2041][/c][/o]?\nI lost it in the [c:64493]dangerous [f:0]planet[/f][/c], somewhere.");
}
```

*Simple not-useful typed text example:*

```AGS Script
FancyTypedText fttb; // has to be global

function room_AfterFadeIn()
{
  fttb.SetDrawingConfig(FancyDrawingConfig.Create(eFontSpeech, 22422));
  fttb.SetDrawingArea(48, 48, 200);
  fttb.Start("Hello!\n[o:8560]Can you find me the [c:27647]blue cup [s:2041][/c][/o]?\nI lost it in the [c:64493]dangerous [f:0]planet[/f][/c], somewhere.");
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

## Script API

### Script Extensions

#### `DrawingSurface.DrawFancyTextWrapped`
```AGS Script
void DrawingSurface.DrawFancyTextWrapped(int x, int y, int width, int color, FontType font, const string text);
```
Draws text with fancy parsing wrapped within specified boundaries on the drawing surface.


### Fancy

This is a global struct you can't instantiate, it contains static methods for global configuration meant to be used at game start.

#### `Fancy.AddAlias`
```AGS Script
static void Fancy.FancyDrawingConfig.AddAlias(String key, int value);
```

Allows adding a global alias to a tag-value. Ex: AddAlias("red", 63488) allows using [c:red] instead of [c:63488].

This may be useful if you want to be able to change your mind later on what is the specific of a color, or you want to have an easier type remembering sprite icons you are reusing in your texts.

Alias added here are global to all of Fancy. It's recommended that you only add an alias once to everything you need at the game_start of your project, make it easier to manage aliases.


### FancyDrawingConfig

This is a managed struct meant to configure an instance from FancyTextBase and extensions, prefer using its `Create` method.

#### `FancyDrawingConfig.Create`
```AGS Script
static FancyDrawingConfig* FancyDrawingConfig.Create(FontType font, int color, Alignment align, int line_spacing);
```
Configuration structure for fancy text drawing, allowing customization of font, text color, line spacing, and alignment.

### FancyTextBase

#### `FancyTextBase.SetDrawingConfig`
```AGS Script
void FancyTextBase.SetDrawingConfig(FancyDrawingConfig* config);
```
Sets the drawing configuration for fancy text rendering.

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
