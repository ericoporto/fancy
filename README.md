# fancy

![build-and-test-windows](https://github.com/ericoporto/fancy/actions/workflows/main.yml/badge.svg)

Fancy is a Script module for "fancy" text in Adventure Game Studio.

With Fancy you can have text with multiple colors, fonts, with sprites and other. It brings it's own Typed-Text mechanism and additional fancyness.

The cheatsheet of tags are below. Some tags are "solo", they don't require a closing tag.

- Color tag is `"[c:123]"` and `"[/c]"`, where `"123"` is an ags color.
- Font tag is `"[f:123]"` and `"[/f]"`, where `"123"` is an ags font index.
- Sprite tag is solo `"[s:123]`, where `"123"` is an ags sprite.

Note: use `"\n"` for linefeed, old lone `"["` ags linefeed is not supported.

## **Usage**

To be written...

## **Script API**

### **Script Extensions**

**DrawingSurface.DrawFancyTextWrapped**
```AGS Script
void DrawingSurface.DrawFancyTextWrapped(int x, int y, int width, int color, FontType font, const string text);
```
Draws text with fancy parsing wrapped within specified boundaries on the drawing surface.

### **FancyDrawingConfig**

**FancyDrawingConfig.Create**
```AGS Script
static FancyDrawingConfig* FancyDrawingConfig.Create(FontType font, int color, Alignment align, int line_spacing);
```
Configuration structure for fancy text drawing, allowing customization of font, text color, line spacing, and alignment.

### **FancyTextBase**

**FancyTextBase.SetDrawingConfig**
```AGS Script
void FancyTextBase.SetDrawingConfig(FancyDrawingConfig* config);
```
Sets the drawing configuration for fancy text rendering.

**FancyTextBase.SetDrawingArea**
```AGS Script
void FancyTextBase.SetDrawingArea(int x, int y, int width = FANCY_INFINITE_WIDTH);
```
Sets the area for drawing fancy text, specifying the position and width.

**FancyTextBase.SetFancyText**
```AGS Script
void FancyTextBase.SetFancyText(String text);
```
Sets the text content for the fancy text box.

**FancyTextBase.Draw**
```AGS Script
void FancyTextBase.Draw(DrawingSurface* surf);
```
Draws the fancy text on the specified drawing surface.

### **FancyTypedText**

**FancyTypedText.Clear**
```AGS Script
void FancyTypedText.Clear();
```
Clears all text and resets everything for typed text.

**FancyTypedText.Start**
```AGS Script
void FancyTypedText.Start(String text);
```
Sets a new string and resets everything to start typing. You can then use Tick repeatedly to advance the text.

**FancyTypedText.Skip**
```AGS Script
void FancyTypedText.Skip();
```
Skips all remaining typing of the text.

**FancyTypedText.Tick**
```AGS Script
void FancyTypedText.Tick();
```
Updates the typed text state, advancing it by a single tick.

**FancyTypedText.DrawTyped**
```AGS Script
void FancyTypedText.DrawTyped(DrawingSurface* surf);
```
Draws the typed text in its current state.