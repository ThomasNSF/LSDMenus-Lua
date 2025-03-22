# LSD Menu System JSON Format Documentation  
**Version 1.0**  
- **Author**: Thomas Pallis  
- **Inspired by**: Nargus Asturias' SIMPLE DIALOG MODULE  
- **License**: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)  
- **Repository**: `git@github.com:ThomasNSF/LSDMenus-Lua.git`  

---

## 1. MENU ROOT OBJECT  
```
{
  "name": "unique_name",   // (string) Menu identifier (e.g., "main_menu")
  "type": "CMD",           // (string) Menu type: "CMD" (Command) or "TXT" (Text-input)
  "msg": "Menu Header",    // (string) Display text. Supports {variable} replacement.
  "var": "default_var",    // (optional) Default variable for buttons.
  "post": "RSH",           // (optional) Post-action behavior: "CLS", "POP", "RSH" (default), "HID"
  "btns": [                // (array) Button definitions (see below).
    { ...button object... },
    ...
  ]
}
```

---

## 2. BUTTON TYPES  

### 2.1 SUBMENU (`"SUB"`)  
Opens another menu.  
```
{
  "type": "SUB",
  "label": "Settings",     // Button label
  "menu": "target_menu",   // Name of menu to open
  "var": "override"        // (optional) Variable override
}
```

### 2.2 ACTION (`"ACT"`)  
Sends a link message.  
```
{
  "type": "ACT",
  "label": "Start Game",   // Button label
  "lnk": LINK_SET,         // Target link number (integer)
  "chn": 42,               // Message channel (integer)
  "msg": "start"           // Message content
}
```

### 2.3 TOGGLE (`"TOG"`)  
Toggles a boolean variable.  
```
{
  "type": "TOG",
  "label": "Sound: {sound}", // Label with variable replacement
  "var": "sound_on"          // Variable to toggle
}
```

### 2.4 TEXT INPUT (`"TXT"`)  
Opens a text input box.  
```
{
  "type": "TXT",
  "label": "Enter Name",    // Button label
  "var": "username",        // Variable to store input
  "hint": "Name: {name}"    // (optional) Input prompt
}
```

### 2.5 SET VALUE (`"SET"`)  
Directly sets a variable's value.  
```
{
  "type": "SET",
  "label": "Set Difficulty", // Button label
  "var": "difficulty",       // Target variable
  "val": "hard"              // Value to assign
}
```

### 2.6 RADIO BUTTON (`"RAD"`)  
Single option in a radio group.  
```
{
  "type": "RAD",
  "label": "Dark Theme",    // Button label
  "var": "theme",           // Shared group variable
  "val": "dark"             // Unique value for this option
}
```

### 2.7 OPTIONS GROUP (`"OPT"`)  
Presents multiple non-exclusive options.  
```
{
  "type": "OPT",
  "label": "Options",       // Group label
  "var": "options",         // Shared group variable
  "hnt": "Select one",      // (optional) Group hint
  "opts": [                 // Option buttons
    { "name": "option 1", "val": "opt1" },
    ...
  ]
}
```

### 2.8 PLACEHOLDER (`"NOP"`)  
Non-interactive button.  
```
{
  "type": "NOP",
  "label": "◌"              // Decorative symbol
}
```

---

## 3. VARIABLE REPLACEMENT  
Use delimiters to include variables in strings:  
- `{variable}`: Fetched from linkset data  
- `[variable]`: Fetched from replacements table  
- `<variable>`: Checks linkset data first, then replacements  
- `<_MENU_>`: Resolves to `current_menu.var`  

**Example**: `"msg": "Health: {health}/100"`  

---

## 4. USAGE NOTES  

### Constants  
- `LNK_SHOWMENU = 40000`  
- `LNK_CLOSEMENU = 40001`  
- `LNK_PUSHMENU = 40002`  
- `LNK_ADDMENU = 40010`  
- `LNK_DELMENU = 40011`  
- `LNK_ADDREPL = 40020`  
- `LNK_DELREPL = 40021`  
- `LNK_MENUOPENED = 50000`  
- `LNK_MENUCLOSED = 50001`  
- `LNK_MENUERROR = 50002`  

### Key Workflows  
1. **Adding Menus**:  
   - Use `LNK_ADDMENU` to validate/store menus.  
   - Pass menu names or JSON via `ll.MessageLinked`.  

2. **Showing Menus**:  
   - `LNK_SHOWMENU`: Replaces current menu.  
   - `LNK_PUSHMENU`: Adds to a stack (enables "Back" navigation).  

3. **Closing Menus**:  
   - `LNK_CLOSEMENU`: Clears the menu stack and listener.  

---

## 5. EXAMPLE MENUS  

### 5.1 Main Menu  
```json
{
  "name": "main",
  "type": "CMD",
  "msg": "Welcome, {user}!",
  "btns": [
    {"type": "SUB", "label": "⚙ Settings", "menu": "settings"},
    {"type": "ACT", "label": "🎮 Start Game", "lnk": -4, "chn": 42, "msg": "start"}
  ]
}
```

### 5.2 Radio Group (Theme Selection)  
```json
{
  "name": "theme_menu",
  "type": "CMD",
  "var": "theme",
  "btns": [
    {"type": "RAD", "label": "Dark", "var": "theme", "val": "dark"},
    {"type": "RAD", "label": "Light", "var": "theme", "val": "light"}
  ]
}
```

---

## 6. BEST PRACTICES  
1. Keep button labels under **24 characters** (Second Life dialog limit).  
2. Reuse variables via the `"var"` field at the menu level.  
