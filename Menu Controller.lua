--[[
    LSD Menu System JSON Format Documentation
    Version 1.0
    - Author: Thomas Pallis 
    - Based (distantly) and inspired by Nargus Asturias' SIMPLE DIALOG MODULE
    - License: CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
    ---------------------------------------------
    
    1. MENU ROOT OBJECT
    ==============================================
    {
      "name": "unique_name",  -- (string) Menu identifier (e.g., "main_menu")
      "type": "CMD",          -- (string) Menu type:
                              --    "CMD" = Command menu
                              --    "TXT" = Text-input menu
      "msg": "Menu Header",   -- (string) Display text. Supports {variable} replacement.
      "var": "default_var",   -- (string, optional) Default variable for buttons.
      "post": "RSH",          -- (string, optional) Post-action behavior:
                              --    "CLS" = Close all menus.
                              --    "POP" = Return to previous menu.
                              --    "RSH" = Refresh menu (default).
                              --    "HID" = Hide temporarily.
      "btns": [               -- (array) Definitions for buttons (see below).
          { ...button object... },
          ...
      ]
    }

    2. BUTTON TYPES (All buttons include the "type" field)
    ==============================================
    
    2.1 SUBMENU ("SUB")
    -------------------------
    Opens another menu.
    {
      "type": "SUB",
      "label": "Settings",     -- (string) Button label.
      "menu": "target_menu",   -- (string) Name of the menu to open.
      "var": "override"        -- (string, optional) Variable override.
    }

    2.2 ACTION ("ACT")
    --------------------------
    Sends a link message.
    {
      "type": "ACT",
      "label": "Start Game",   -- (string) Button label.
      "lnk": LINK_SET,         -- (integer) Target link number.
      "chn": 42,               -- (integer) Message channel.
      "msg": "start"           -- (string) Message content.
    }

    2.3 TOGGLE ("TOG")
    --------------------------
    Toggles a boolean variable.
    {
      "type": "TOG",
      "label": "Sound: {sound}",  -- (string) Label with variable replacement.
      "var": "sound_on"           -- (string) Variable to toggle.
    }

    2.4 TEXT INPUT ("TXT")
    ----------------------
    Opens a text input box.
    {
      "type": "TXT",
      "label": "Enter Name",   -- (string) Button label.
      "var": "username",       -- (string) Variable to store input.
      "hint": "Name: {name}"   -- (string, optional) Input prompt.
    }

    2.5 SET VALUE ("SET")
    -----------------------
    Directly sets the value of a variable.
    {
      "type": "SET",
      "label": "Set Difficulty",  -- (string) Button label.
      "var": "difficulty",        -- (string) Target variable.
      "val": "hard"               -- (string) Value to assign.
    }

    2.6 RADIO BUTTON ("RAD")
    --------------------
    Single option in a radio group (displayed with auto-updated markers).
    {
      "type": "RAD",
      "label": "Dark Theme",  -- (string) Button label.
      "var": "theme",         -- (string) Shared group variable.
      "val": "dark"           -- (string) Unique value for this option.
    }

    2.7 OPTIONS GROUP ("OPT")
    -------------------
    Presents multiple options in a non-exclusive group.
    {
      "type": "OPT",
      "label": "Options",      -- (string) Group label.
      "var": "options",        -- (string) Shared group variable.
      "hnt": "Select one",     -- (string, optional) Group hint.
      "opts": [                -- (array) Option buttons.
          { "name": "option 1", "val": "opt1" },
          ...
      ]
    }

    2.8 PLACEHOLDER ("NOP")
    ---------------------
    A non-interactive (decorative) button.
    {
      "type": "NOP",
      "label": "◌"           -- (string) Decorative symbol.
    }

    3. VARIABLE REPLACEMENT
    ==============================================
    Use delimiters to include variables in strings:
      - {variable} : Fetched from linkset data.
      - [variable] : Fetched from the replacements table.
      - <variable> : Checks linkset data first, then replacements.
      - <_MENU_>   : Resolves to "current_menu.var" from the active menu.
    Example: "msg": "Health: {health}/100"
    
    5. USAGE NOTES
    ==============================================
    
    1. Overview
    Communication between this menu script and the menu system in Second Life is based on 
    link messages (ll.MessageLinked),

    The following constants are used:

    - LNK_SHOWMENU = 40000
    - LNK_CLOSEMENU = 40001
    - LNK_PUSHMENU = 40002
    - LNK_ADDMENU = 40010
    - LNK_DELMENU = 40011
    - LNK_ADDREPL = 40020
    - LNK_DELREPL = 40021
    - LNK_MENUOPENED = 50000
    - LNK_MENUCLOSED = 50001
    - LNK_MENUERROR = 50002

    2. Adding and showing menus
    A script may add new menus using the LNK_ADDMENU, LNK_SHOWMENU, and LNK_PUSHMENU messages.

    - LNK_ADDMENU validates and stores a new menu definition.  If there is an error in the menu
    definition, the script sends an LNK_MENUERROR message.  The menu definition is passed through 
    the str parameter of the llMessageLinked.

    - LNK_SHOWMENU and LNK_PUSHMENU display a menu to a specific user. 
    The string parameter of llMessageLinked for both these commands contain either the name of the 
    menu to display or the JSON menu definition.  The id parameter of llMessageLinked is the UUID 
    of the target agent.

        2.1 Passing a menu definition
        To pass a menu definition, the script sends an LNK_SHOWMENU or LNK_PUSHMENU message with the
        JSON menu definition as the string parameter.  The menu definition must be a valid JSON object
        conforming to the LSD Menu System JSON Format.  If the menu definition does not include a name
        the menu is not stored in the menu system.  This allows for temporary menus that are displayed
        once and then discarded.
            
        2.2 Showing a stored menu
        If the string parameter contains the name of a stored menu, the script displays the menu to the
        target agent.  The menu must have been previously added.  The passed menu name may optionally 
        include a variable override in the format "menu_name:variable_name".  This allows the script to
        display the menu with a different variable scope than the default.

        2.3 Pushing vs. showing
        The LNK_SHOWMENU message displays the menu to the target agent, replacing any previously displayed
        menu.  The LNK_PUSHMENU message adds the menu to a stack, allowing the user to return to the previous
        menu using the "Back" button.  The script may use the LNK_PUSHMENU message to display a series of
        related menus.

    3. Closing menus
    A script may close the active menu using the LNK_CLOSEMENU message.  This message has no parameters.
    It erases the current menu stack and removes the active listener. This command does not close any 
    the dialog box or text input box that the user may have open on the viewer.

    4. Deleting menus
    A script may delete a stored menu definition using the LNK_DELMENU message.  The string parameter of
    llMessageLinked contains the name of the menu to delete.  

    5. Replacing variables
    A script may specify variable replacements using the LNK_ADDREPL message.  The string parameter of
    llMessageLinked contains a JSON object with key-value pairs.  The script may remove a variable 
    replacement using the LNK_DELREPL message.  The string parameter contains the name of the variable to
    remove.
    
    5. EXAMPLE MENUS
    ==============================================
    
    5.1 Main Menu
    {
      "name": "main",
      "type": "CMD",
      "msg": "Welcome, {user}!",
      "btns": [
          {"type": "SUB", "label": "⚙ Settings", "menu": "settings"},
          {"type": "ACT", "label": "🎮 Start Game", "lnk": -4, "chn": 42, "msg": "start"}
      ]
    }

    5.2 Radio Group (Theme Selection)
    Note: Use a command menu ("CMD") for radio groups.
    {
      "name": "theme_menu",
      "type": "CMD",
      "var": "theme",
      "btns": [
          {"type": "RAD", "label": "Dark", "var": "theme", "val": "dark"},
          {"type": "RAD", "label": "Light", "var": "theme", "val": "light"}
      ]
    }

    6. BEST PRACTICES
    ==============================================
    1. Keep "label" under 24 characters (Second Life dialog limit).
    2. Reuse variables via the "var" field at the menu level.

    VERSION
    ==============================================
    LSD Menu System v1.0.0.1
]]

---------------------------------------------------------------------

-- Define constants in a module
local CONST = {
    LNK_SHOWMENU =  40000,  -- Display a menu
    LNK_CLOSEMENU = 40001,  -- Clean up menu state
    LNK_PUSHMENU =  40002,  -- Add menu to stack
    LNK_ADDMENU =   40010,  -- Store menu definition
    LNK_DELMENU =   40011,  -- Remove menu definition
    LNK_ADDREPL =   40020,  -- Update replacements
    LNK_DELREPL =   40021,  -- Remove replacements

    LNK_MENUOPENED = 50000, -- Menu has been opened
    LNK_MENUCLOSED = 50001, -- Menu has been closed
    LNK_MENUERROR =  50002, -- Menu error occurred

    LBL_BLANK =     "◌",
    LBL_UP =        "⇧ Up",
    LBL_CLOSE =     "Close",
    LBL_BACK =      "⟸ Back",
    LBL_NEXT =      "⟹ Next",

    MENU_PREFIX = "_.MENU."
}

---------------------------------------------------------------------
-- Global tables to maintain state (equivalent to LSL global variables)
local REPLACEMENTS = {}
local MENU_TIMEOUT = 300

local MENU_STACK = nil

local ACTIVE_CHANNELS = {}

---------------------------------------------------------------------
local function toboolean(value)
    if type(value) == "string" then
        if tonumber(value) then return true
        elseif value == "0" then return false end
        local lower = value:lower()
        if lower == "true" then return true
        elseif lower == "false" then return false end
    end
    return not not value -- Fallback to truthy/falsy
end

function report_error(message)
    ll.MessageLinked(LINK_SET, CONST.LNK_MENUERROR, message, NULL_KEY)
end

function debug(message)
    if toboolean(ll.LinksetDataRead("MENU.DEBUG")) then
        ll.Say(0x7FFFFFFF, message)
    end
    report_error(message)
end

function trim(s)
    return s:match("^%s*(.-)%s*$")
end

---------------------------------------------------------------------
-- JSON handling
---------------------------------------------------------------------
local JSON = {}
JSON.encode = function (val)
    -- Helper to decide if a table is an array (consecutive positive integer keys)
    local function is_array(t)
        local max = 0
        local count = 0
        for k, _ in pairs(t) do
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                return false
            end
            if k > max then
                max = k
            end
            count = count + 1
        end
        return max == count
    end

    -- Escapes string characters for safe JSON output
    local function escape_string(s)
        s = s:gsub('\\', '\\\\')
        s = s:gsub('"', '\\"')
        s = s:gsub('\b', '\\b')
        s = s:gsub('\f', '\\f')
        s = s:gsub('\n', '\\n')
        s = s:gsub('\r', '\\r')
        s = s:gsub('\t', '\\t')
        return s
    end

    -- Recursively encodes values based on type
    local function encode_val(v)
        local t = type(v)
        if t == "nil" then
            return "null"
        elseif t == "boolean" then
            return v and "true" or "false"
        elseif t == "number" then
            return tostring(v)
        elseif t == "string" then
            return '"' .. escape_string(v) .. '"'
        elseif t == "table" then
            local items = {}
            if is_array(v) then
                for i = 1, #v do
                    table.insert(items, encode_val(v[i]))
                end
                return "[" .. table.concat(items, ",") .. "]"
            else
                for k, v in pairs(v) do
                    if type(k) ~= "string" then
                        error("JSON object keys must be strings")
                    end
                    table.insert(items, encode_val(k) .. ":" .. encode_val(v))
                end
                return "{" .. table.concat(items, ",") .. "}"
            end
        else
            error("Unsupported type: " .. t)
        end
    end

    return encode_val(val)
end

JSON.decode = function(str)
    local pos = 1
    local skip_whitespace, parse_array, parse_string, parse_number, parse_object, parse_value

    skip_whitespace = function ()
        while pos <= #str do
            local c = str:sub(pos, pos)
            if c == " " or c == "\t" or c == "\n" or c == "\r" then
                pos = pos + 1
            else
                break
            end
        end
    end

    parse_array = function ()
        local arr = {}
        pos = pos + 1  -- skip '['
        skip_whitespace()
        if str:sub(pos, pos) == "]" then
            pos = pos + 1
            return arr
        end
        local index = 1
        while true do
            skip_whitespace()
            arr[index] = parse_value()
            index = index + 1
            skip_whitespace()
            local delimiter = str:sub(pos, pos)
            if delimiter == "]" then
                pos = pos + 1
                break
            elseif delimiter == "," then
                pos = pos + 1
            else
                error("Expected ',' or ']' at position " .. pos)
            end
        end
        return arr
    end

    parse_string = function ()
        pos = pos + 1  -- skip opening quote
        local start = pos
        local result = ""
        while pos <= #str do
            local c = str:sub(pos, pos)
            if c == '"' then
                result = result .. str:sub(start, pos - 1)
                pos = pos + 1  -- skip closing quote
                return result
            elseif c == "\\" then
                result = result .. str:sub(start, pos - 1)
                pos = pos + 1
                local escape = str:sub(pos, pos)
                if escape == "u" then
                    local hex = str:sub(pos + 1, pos + 4)
                    result = result .. utf8.char(tonumber(hex, 16))
                    pos = pos + 4
                elseif escape == '"' or escape == "\\" or escape == "/" then
                    result = result .. escape
                    pos = pos + 1
                elseif escape == "b" then
                    result = result .. "\b"
                    pos = pos + 1
                elseif escape == "f" then
                    result = result .. "\f"
                    pos = pos + 1
                elseif escape == "n" then
                    result = result .. "\n"
                    pos = pos + 1
                elseif escape == "r" then
                    result = result .. "\r"
                    pos = pos + 1
                elseif escape == "t" then
                    result = result .. "\t"
                    pos = pos + 1
                else
                    error("Invalid escape sequence at position " .. pos)
                end
                start = pos
            else
                pos = pos + 1
            end
        end
        error("Unterminated string starting at position " .. start)
    end

    parse_number = function ()
        local start = pos
        while pos <= #str and str:sub(pos, pos):match("[0-9+%-eE%.]") do
            pos = pos + 1
        end
        local num_str = str:sub(start, pos - 1)
        local number = tonumber(num_str)
        if not number then
            debug("Invalid number: " .. num_str .. " at position " .. start)
        end
        return number
    end

    parse_object = function ()
        local obj = {}
        pos = pos + 1  -- skip '{'
        skip_whitespace()
        if str:sub(pos, pos) == "}" then
            pos = pos + 1
            return obj
        end
        while true do
            skip_whitespace()
            if str:sub(pos, pos) ~= '"' then
                ll.Say(0x7FFFFFFF, "Expected string for key at position " .. pos)
            end
            local key = parse_string()
            skip_whitespace()
            if str:sub(pos, pos) ~= ":" then
                ll.Say(0x7FFFFFFF, "Expected ':' after key at position " .. pos)
            end
            pos = pos + 1  -- skip ':'
            skip_whitespace()
            local value = parse_value()
            obj[key] = value
            skip_whitespace()
            local delimiter = str:sub(pos, pos)
            if delimiter == "}" then
                pos = pos + 1
                break
            elseif delimiter == "," then
                pos = pos + 1
            else
                debug("Expected ',' or '}' at position " .. pos)
            end
        end
        return obj
    end

    parse_value = function()
        skip_whitespace()
        local c = str:sub(pos, pos)
        if c == "{" then
            return parse_object()
        elseif c == "[" then
            return parse_array()
        elseif c == '"' then
            return parse_string()
        elseif c == "-" or c:match("%d") then
            return parse_number()
        elseif str:sub(pos, pos+3) == "true" then
            pos = pos + 4
            return true
        elseif str:sub(pos, pos+4) == "false" then
            pos = pos + 5
            return false
        elseif str:sub(pos, pos+3) == "null" then
            pos = pos + 4
            return nil
        else
            debug("Unexpected character '" .. c .. "' at position " .. pos)
            return nil
        end
    end

    return parse_value()
end

---------------------------------------------------------------------
--[[
    Replaces template variables in a string with values from specified sources.
    Supports nested variables and multiple syntax types:
    - {variable}    : Fetched from linkset data
    - [variable]    : Fetched from replacements table
    - <variable>    : Checks linkset data first, then replacements
    - <_MENU_var>   : Resolves to "current_menu.var" in linkset data

    @param source        (string)  Input text containing variables to replace
    @param replacements  (table)   Key-value pairs for [variable] replacements
    @param current_menu  (string)  Base key prefix for <_MENU_*> variables (optional)
    @param max_depth     (number)  Maximum recursion depth to prevent infinite loops (default: 5)

    @return (string) Processed string with variables replaced

    Example 1: Basic replacement
        replace_variables("Hello {name}", {}, {name = "Alice"}, nil)
        --> "Hello Alice"

    Example 2: Nested variables
        replace_variables("Value: {outer}", {}, {outer = "<inner>", inner = "42"}, nil)
        --> "Value: 42"

    Example 3: Menu context variables
        replace_variables("Bonus: <_MENU_bonus>", {}, {player_stats_bonus = 5}, "player_stats")
        --> "Bonus: 5"

    Notes:
    1. Missing variables remain in output (e.g., "{missing}" stays "{missing}")
    2. Handles arbitrary nesting of same-type delimiters
    3. Unterminated variables (e.g., "{unclosed") are preserved literally
]]
function replace_variables(source, current_menu, max_depth)
    if not source then return "" end
    max_depth = max_depth or 5

    local DELIMITERS = {
        ['{'] = {close = '}', mode = 'data'},
        ['['] = {close = ']', mode = 'replace'},
        ['<'] = {close = '>', mode = 'both'},
    }

    local function process_variable(var_name, delim)
        if delim.open == '<' and var_name == "_MENU_" then
            var_name = (MENU_STACK and MENU_STACK.variable) or (current_menu and current_menu.var) or var_name
        end

        local value
        if delim.mode == 'data' then
            value = ll.LinksetDataRead(var_name)
        elseif delim.mode == 'replace' then
            value = REPLACEMENTS[var_name]
        else
            value = ll.LinksetDataRead(var_name) or REPLACEMENTS[var_name]
        end

        if value and max_depth > 0 then
            value = replace_variables(tostring(value), current_menu, max_depth - 1)
        end

        return value or (delim.open .. var_name .. delim.close)
    end

    local output = {}
    local stack = {}
    local i = 1
    local len = #source

    while i <= len do
        local char = source:sub(i, i)
        local delim = DELIMITERS[char]

        if delim and #stack == 0 and max_depth > 0 then
            table.insert(stack, {open = char, close = delim.close, mode = delim.mode, start = i})
            i = i + 1
        elseif #stack > 0 then
            local current = stack[#stack]
            if char == current.close then
                local var_name = source:sub(current.start + 1, i - 1)
                table.remove(stack)
                table.insert(output, process_variable(var_name, current))
                i = i + 1
            elseif DELIMITERS[char] and char == current.open then
                table.insert(stack, {open = char, close = current.close, mode = current.mode, start = i})
                i = i + 1
            else
                i = i + 1
            end
        else
            table.insert(output, char)
            i = i + 1
        end
    end

    for _, item in ipairs(stack) do
        table.insert(output, source:sub(item.start, len))
    end

    return table.concat(output)
end

---------------------------------------------------------------------
--[[
    Closes the active menu and cleans up related resources
    @param send_message (boolean) Whether to send LNK_MENUCLOSED notification
    @sideeffect
        - Removes active listener if present
        - Stops menu timeout timer
        - Clears global MENU_STACK
        - Sends LNK_MENUCLOSED message if requested
    
    @note
        - Safe to call even if no menu is open (no-op)
        - Automatically handles nil/invalid menu states
        - Idempotent - multiple calls have same effect as single call
]]
function menu_close(send_message)
    -- Send menu closed notification if requested
    if not MENU_STACK then return end
    
    if send_message then
        local menu_name = MENU_STACK.menu_def.name or ""
        ll.MessageLinked(LINK_SET, CONST.LNK_MENUCLOSED, menu_name, "")
    end

    if MENU_STACK.listen then 
        ll.ListenRemove(MENU_STACK.listen) 
    end
    ll.SetTimerEvent(0)
    
    MENU_STACK = nil
end

--[[
    Displays the current menu state to a specific user
    @param user_id (string) UUID of target avatar
    @sideeffect
        - Creates/updates menu listener channel
        - Sends dialog or text input
        - Sets menu timeout timer
        - Updates menu stack state
]]
function show_active_menu(user_id)
    --[[
        Prepares button labels and mappings for menu display
        @param current_page (number) 1-based current page number
        @param total_buttons (number) Total content buttons in the menu
        @param buttons_per_page (number) 9 (paginated) or 12 (single page)
        @return (table, table)
            1. ordered_labels: Array of button labels with navigation first
            2. label_to_index: Map of labels to button indices/special codes
    ]]
    function prepare_buttons(current_menu, current_page, buttons_per_page)
        local ordered_labels = {}
        local label_to_index = {}
        local has_parent = MENU_STACK.parent ~= nil
        local total_buttons = #current_menu.btns

        -- Calculate page indices
        local start_idx = (current_page - 1) * buttons_per_page + 1
        local end_idx = math.min(current_page * buttons_per_page, total_buttons)

        -- Process content buttons
        for i = start_idx, end_idx do
            local btn = current_menu.btns[i]
            if not btn then break end

            -- Replace variables and add state markers
            local label = replace_variables(btn.label, current_menu)
            if btn.type == "TOG" or btn.type == "RAD" then
                local var_name = btn.var or current_menu.var
                if (var_name) then
                    local current_val = ll.LinksetDataRead(var_name)

                    local is_active = false
                    if btn.type == "TOG" then
                        is_active = toboolean(current_val)
                    else
                        is_active = (btn.val == current_val)
                    end
                    label = (is_active and "◉ " or "○ ") .. label
                else
                    label = "? " .. label
                end
            end
            
            -- Trim and store
            label = label:sub(1, 24):gsub("%s+", " ")
            table.insert(ordered_labels, label)
            label_to_index[label] = i
        end

        -- Add navigation buttons if paginated (9 buttons_per_page)
        if buttons_per_page == 9 then
            local total_pages = math.ceil(total_buttons / buttons_per_page)
            
            -- Back/Close/Next buttons
            local nav_labels = {
                current_page > 1 and CONST.LBL_BACK or CONST.LBL_BLANK,
                has_parent and CONST.LBL_UP or CONST.LBL_CLOSE,
                current_page < total_pages and CONST.LBL_NEXT or CONST.LBL_BLANK
            }

            -- Insert navigation at positions 1-3
            for i, label in ipairs(nav_labels) do
                table.insert(ordered_labels, i, label)
                label_to_index[label] = -i  -- -1=Back, -2=Close/Up, -3=Next
            end
        end
        
        return ordered_labels, label_to_index
    end

    -- Validate inputs and menu state
    if not user_id or tostring(user_id) == "" then return end
    if not MENU_STACK then return end
    user_id = tostring(user_id)

    -- Generate unique channel ID from user+timestamp hash
    local channel = ll.Hash(user_id .. ll.GetTimestamp())
    MENU_STACK.channel = channel

    -- Create new listener
    MENU_STACK.listen = ll.Listen(channel, "", user_id, "")

    -- Prepare UI elements
    local message = MENU_STACK.menu_def.msg and replace_variables(MENU_STACK.menu_def.msg, MENU_STACK.menu_def) or ""
    if MENU_STACK.menu_def.type == "TXT" then
        ll.TextBox(user_id, message, channel)
    else
        local ordered_buttons, active_buttons = prepare_buttons(MENU_STACK.menu_def, MENU_STACK.cur_page, MENU_STACK.btns_per_page)

        -- Store response mapping
        MENU_STACK.active_buttons = active_buttons

        -- Send appropriate menu type
        ll.Dialog(user_id, message, ordered_buttons, channel)
    end

    -- System notifications
    local menu_name = MENU_STACK.menu_def.name or "_temp_"
    ll.MessageLinked(LINK_SET, CONST.LNK_MENUOPENED, menu_name, user_id)
    ll.SetTimerEvent(MENU_TIMEOUT or 60.0)  -- Default 60s timeout
end

--[[
    Initializes and displays a menu to the specified user
    @param user_id (string) Target user's UUID
    @param menu_name (string) Identifier for the menu
    @param page (number) 1-based page number
    @param var_override (string) Optional variable scope override
    @param menu_def (table|string) Menu definition (JSON table or name)
    @return (boolean) True if menu was successfully shown
    
    @sideeffect
        - Updates global menu state (CUR_MENU_* variables)
        - Modifies MENU_STACK
        - Creates menu listener channel
]]
function menu_do(user_id, menu_name, page, var_override, menu_def)
    --[[
        Calculates menu pagination limits based on Second Life's dialog constraints
        @param button_count (number) Total number of menu content buttons (excludes navigation)
        @return 
            per_page: Max content buttons per page (9 when paginated, 12 otherwise)
            total: Total number of pages required
    ]]
    function get_button_range(button_count)
        --local SL_MAX_BUTTONS = 12
        local CONTENT_PER_PAGE = 9
        
        -- Paginated mode (9 content + 3 nav buttons per page)
        local total_pages = math.ceil(button_count / CONTENT_PER_PAGE)
        return CONTENT_PER_PAGE, total_pages
    end

    -- Validate critical parameters
    if not user_id or user_id == "" then return false end

    -- Set current menu state
    local new_stack = {
        menu_def = menu_def,
        page = 1,                   -- Current 1-based page number
        variable = menu_def.var,    -- Active variable scope/override
        user_id = user_id,          -- Target user's UUID
        parent = MENU_STACK,        -- Reference to parent menu (optional, if hierarchical)
    }

    new_stack.button_count = menu_def.btns and #menu_def.btns or 0

    if var_override and var_override ~= "" then new_stack.variable = var_override end
    
    local button_count = 0
    local page_count = 1
    if menu_def.btns and #menu_def.btns >  0 then
        button_count, page_count = get_button_range(#menu_def.btns)
    end
    new_stack.btns_per_page = button_count
    new_stack.page_count = page_count
    new_stack.cur_page = 1
    
    MENU_STACK = new_stack

    show_active_menu(user_id)
    return
end

function menu_pop(user_id)
    if MENU_STACK and MENU_STACK.parent then
        MENU_STACK = MENU_STACK.parent
        show_active_menu(user_id)
    else
        menu_close(true)
    end
end

function menu_page(user_id, delta)
    -- Validate menu state and user context
    if not MENU_STACK or MENU_STACK.user_id ~= user_id then 
        menu_close()
        return 
    end

    -- Calculate new page number with boundary checks
    local new_page = MENU_STACK.cur_page + delta

    -- Clamp page number to valid range
    if new_page < 1 then
        new_page = 1
    elseif new_page > MENU_STACK.page_count then
        new_page = MENU_STACK.page_count
    end

    MENU_STACK.cur_page = new_page
    
    -- Refresh menu display
    show_active_menu(user_id)
    
end

---------------------------------------------------------------------
--[[
    Detailed Description: menu_process
    -----------------------------------
    Processes a user action by interpreting the button text input received from the menu.
    
    If the current active menu is of type "TXT", the function writes the user's text input to the
    corresponding variable and applies the text menu's post-action.

    For dialog menus:
      - It retrieves the active button mapping from MENU_STACK.active_buttons based on the provided button text.
      - It validates the selection and obtains the button definition from the menu.
      - It dispatches the action using a handler table keyed by the button type (e.g., SUB, ACT, TOG, TXT, OPT, SET, RAD, NOP).
      - The invoked handler function performs tasks such as changing variables, sending messages, or updating the menu state.
      - Once the action is processed, the function checks the returned post-action value:
            * "CLS": Closes the menu.
            * "POP": Returns to the previous menu.
            * "RSH": Refreshes the current menu display.
            * "HID": Leaves the menu hidden.
    
    @param user_id (string): The unique identifier (UUID) for the target user.
    @param btn_text (string): The text input received; either directly from a text box or identifying the selected button.
    
    @sideeffect:
      - Updates global MENU_STACK and may trigger a menu refresh, close, or navigation to a different menu state.
]]
function menu_process(user_id, btn_text)
    local handlers = {
        -- SUB: Opens a submenu by pushing a new menu onto the menu stack.
        -- It retrieves the target submenu name from btn_def.menu and sends a message to load that submenu.
        -- The handler returns "HID" to indicate that the current menu should be hidden.
        SUB = function (menu_def, btn_def)
            local var_override = btn_def.var
            -- TODO: pass variable override if needed.
            ll.MessageLinked(LINK_THIS, CONST.LNK_PUSHMENU, btn_def.menu, user_id)
            return "HID"
        end,
        
        -- ACT: Processes an action button by sending a link message.
        -- It obtains the message template from btn_def.msg, performs variable substitution,
        -- and sends the resulting message to the designated channel/link.
        -- The handler returns a post-action command (defaulting to "CLS") to determine further behavior.
        ACT = function (menu_def, btn_def)
            local message = replace_variables(btn_def.msg, menu_def)
            ll.MessageLinked(btn_def.lnk or LINK_SET, btn_def.chn or 0, message, user_id)
            return btn_def.post or menu_def.post or "CLS"
        end,
        
        -- TOG: Toggles a boolean variable.
        -- It reads the current state of the variable via ll.LinksetDataRead,
        -- toggles the value, writes back the new state as a string ("true" or "false"),
        -- and then returns a post-action command (defaulting to "RSH").
        TOG = function (menu_def, btn_def)
            local val = not toboolean(ll.LinksetDataRead(btn_def.var))
            ll.LinksetDataWrite(btn_def.var, val and "true" or "false")
            return btn_def.post or menu_def.post or "RSH"
        end,
        
        -- TXT: Invokes a text input dialog for the user.
        -- It constructs a new text input menu using btn_def.hint and variable settings,
        -- then calls menu_do to display the text input. The handler returns "HID".
        TXT = function (menu_def, btn_def)
            local text_input = {
               type = "TXT",
               msg = btn_def.hint,
               var = btn_def.var or menu_def.var,
               post = btn_def.post or "POP"
            }
            if MENU_STACK.variable and MENU_STACK.variable ~= "" then
                text_input.var = MENU_STACK.variable
            end
            menu_do(user_id, nil, 1, MENU_STACK.variable, text_input)
            return "HID"
        end,

        -- OPT: Constructs an options group menu.
        -- It iterates over options provided in btn_def.opts, builds radio button items,
        -- and then creates a new command menu displaying these options.
        -- The handler finally returns "HID" to hide the current menu.
        OPT = function (menu_def, btn_def)
            local var = btn_def.var or menu_def.var
            local options = btn_def.opts
            if MENU_STACK.variable and MENU_STACK.variable ~= "" then
                var = MENU_STACK.variable
            end
            local buttons = {}
            for _, option in ipairs(options) do
                table.insert(buttons, { type = "RAD", var = var, val = option.val, label = option.name })
            end
            local menu = {
                type = "CMD",
                msg = btn_def.hnt or btn_def.label,
                var = var,
                btns = buttons,
                post = btn_def.post or "POP"
            }
            menu_do(user_id, nil, 1, nil, menu)
            return "HID"
        end,
        
        -- SET: Directly assigns a specified value to a variable.
        -- It selects the variable from either MENU_STACK.variable or btn_def.var/menu_def.var,
        -- writes btn_def.val using ll.LinksetDataWrite, and returns a post-action command (default "RSH").
        SET = function (menu_def, btn_def)
            local variable
            if MENU_STACK.variable and MENU_STACK.variable ~= "" then 
                variable = MENU_STACK.variable 
            else 
                variable = btn_def.var or menu_def.var 
            end            
            ll.LinksetDataWrite(variable, tostring(btn_def.val))
            return btn_def.post or menu_def.post or "RSH"
        end,
        
        -- RAD: Processes a radio button selection.
        -- It writes the selected radio option's value to the associated variable,
        -- choosing between MENU_STACK.variable and btn_def.var/menu_def.var,
        -- and returns a post-action command, typically "RSH".
        RAD = function (menu_def, btn_def)
            local variable 
            if MENU_STACK.variable and MENU_STACK.variable ~= "" then 
                variable = MENU_STACK.variable 
            else 
                variable = btn_def.var or menu_def.var 
            end
            ll.LinksetDataWrite(variable, tostring(btn_def.val))
            return btn_def.post or menu_def.post or "RSH"
        end,
        
        -- NOP: Represents a no-operation action.
        -- This handler does nothing except return the post-action command (default "RSH"),
        -- effectively refreshing the current menu.
        NOP = function (menu_def, btn_def)
            return btn_def.post or menu_def.post or "RSH"
        end
    }
    local post
    if MENU_STACK.menu_def.type == "TXT" then
        local variable = MENU_STACK.variable or MENU_STACK.menu_def.var
        ll.LinksetDataWrite(variable, btn_text)
        post = MENU_STACK.menu_def.post or "POP"
    else
        -- Get button mapping and find selected index
        local button_index = MENU_STACK.active_buttons[btn_text]

        -- Handle invalid/missing button selection
        if not button_index then
            return
        end

        -- Get actual button definition
        local btn_def = MENU_STACK.menu_def.btns[button_index]
        if not btn_def then
            return
        end

        if not btn_def.type or btn_def.type == "NOP" then 
            show_active_menu(user_id)
            return
        end
        
        local proc = handlers[btn_def.type]
        if not proc then
            return
        end
        
        post = proc(MENU_STACK.menu_def, btn_def)
    end

    if post == "CLS" then
        menu_close(true)
    elseif post == "POP" then
        menu_pop(user_id)
    elseif post == "RSH" then
        show_active_menu(user_id)
    end -- for "HID" do nothing
end

---------------------------------------------------------------------
--[[
    Detailed Description: validate_menu
    -----------------------------------
    This function validates a menu definition table to ensure it conforms
    to the expected JSON format for menus. The validations include:
      - Confirming the input is a table.
      - Verifying that the menu 'type' is specified as a string and is one of the allowed types ("CMD" or "TXT").
      - Checking that if a 'post' action is provided, it is one of the valid values ("CLS", "POP", "RSH", "HID").
      - Ensuring the optional 'var' property (if provided) is a string.
      - Verifying that the menu contains a 'msg' property as a string for display purposes.
    
    For menus containing buttons (non-text menus):
      - The 'btns' property must be a table array.
      - Each button in the array must be a table with at least a 'type' and 'label' property.
      - Additional button validations depend on the type of the button:
          * For "SUB": A target menu must be specified.
          * For "ACT": Link, channel, and message fields are required.
          * For "TOG": A variable must be provided.
          * For "RAD": Both variable and value must be provided.
          * For "TXT": A variable and hint are required.
          * For "OPT": A variable and options are required.
      - If any validation fails, the function returns false along with a descriptive error message.
    
    @param menu_def (table): The menu definition to validate.
    @return boolean, string: Returns true without a message if validation passes, otherwise false with an error message.
]]
function validate_menu(menu_def)
    -- Basic type check
    if type(menu_def) ~= "table" then
        return false, "Menu definition must be a table"
    end

    if type(menu_def.type) ~= "string" then
        return false, "Menu type must be a string"
    end

    -- Menu type validation
    local valid_types = {
        CMD = true,  -- Command menu
        TXT = true   -- Text input menu
    }
    if not valid_types[menu_def.type] then
        return false, string.format("Invalid menu type: %s", menu_def.type)
    end

    -- Post-action validation
    if menu_def.post and not (menu_def.post == "CLS" or 
                             menu_def.post == "POP" or 
                             menu_def.post == "RSH" or 
                             menu_def.post == "HID") then
        return false, string.format("Invalid post-action: %s", menu_def.post)
    end

    if menu_def.var and type(menu_def.var) ~= "string" then 
        return false, "Menu variable must be a string."
    end

    if type(menu_def.msg) ~= "string" then
        return false, "Missing menu message."
    end

    if menu_def.btns and menu_def.type == "TXT" then
        return false, "Buttons not allowed on text entry."
    else
        -- Button validation
        if type(menu_def.btns) ~= "table" then
            return false, "Buttons must be a table array"
        end

        local button_validators = {
            SUB = function(btn)
                if not btn.menu then return false, "Missing target menu (" .. (menu_def.name or "unnamed") .. ")" end
                return true
            end,
            ACT = function(btn)
                if not (btn.lnk and btn.chn and btn.msg) then
                    return false, "Missing link/chn/msg fields"
                end
                return true
            end,
            TOG = function(btn)
                if not btn.var then return false, "Missing variable (var)" end
                return true
            end,
            RAD = function(btn)
                if not (btn.var and btn.val) then
                    return false, "Missing var/val fields"
                end
                return true
            end,
            TXT = function(btn)
                if not (btn.var and btn.hint) then return false, "Missing variable or hint (var/hint)" end
                return true
            end,
            OPT = function(btn)
                if not btn.var then return false, "Missing variable (var)" end
                if not btn.opts then return false, "Missing options (opts)" end
                return true
            end,
            NOP = function(btn) return true end
        }

        for i, btn in ipairs(menu_def.btns) do
            if type(btn) ~= "table" then
                return false, string.format("Button %d is not a table", i)
            end

            if not btn.type then
                return false, string.format("Button %d: Missing button type.", i)
            end
            if not btn.label then
                return false, string.format("Button %d: Missing button label.", i)
            end

            local validator = button_validators[btn.type]
            if not validator then
                return false, string.format("Button %d: Invalid type %s", i, btn.type)
            end

            local valid, err = validator(btn)
            if valid ~= true then
                return false, string.format("Button %d: %s", i, err)
            end
        end
    end

    return true, "Valid menu definition"
end

---------------------------------------------------------------------
function add_validate(menu_def, store)
    local valid, message = validate_menu(menu_def)
    if not valid then
        report_error(message)
        return false, nil
    end

    if menu_def.name == "" then
        menu_def.name = nil
    end

    if menu_def.name then
        ll.LinksetDataWrite(CONST.MENU_PREFIX..menu_def.name, JSON.encode(menu_def))
    end
    return true, menu_def.name
end

function resolve_menu(menu_desc)
    local success, menu_def = pcall(JSON.decode, menu_desc)
    local menu_name
    local var_override

    if success and type(menu_def) == "table" then
        success, menu_name = add_validate(menu_def)
        if not success then
            return nil, nil, nil
        end
    else
        local colonPos = menu_desc:find(":")
        if colonPos then
            menu_name = menu_desc:sub(1, colonPos - 1)
            var_override = menu_desc:sub(colonPos + 1)
        else
            menu_name = menu_desc
        end

        menu_desc = ll.LinksetDataRead(CONST.MENU_PREFIX .. menu_name)
        if not menu_desc or menu_desc == "" then
            report_error("Menu not found: " .. menu_name)
            return nil, nil, nil
        end
        success, menu_def = pcall(JSON.decode, menu_desc)
        if not success or type(menu_def) ~= "table" then
            report_error("Invalid menu definition: " .. menu_name)
            return nil, nil, nil
        end
    end
    return menu_name, menu_def, var_override
end

---------------------------------------------------------------------
-- Link message handler
function link_message(sender_num, num, str, id)

    -- LNK_SHOWMENU (40000): Display a menu
    -- LNK_PUSHMENU (40002): Add menu to stack
    if num == CONST.LNK_SHOWMENU or num == CONST.LNK_PUSHMENU then
        if not str or str == "" then 
            show_active_menu(id)
        else
            local menu_name, menu_def, var_override = resolve_menu(str)
            if not menu_def then
                return
            end

            if num == CONST.LNK_SHOWMENU then
                MENU_STACK = nil  -- Reset stack
            end
            
            menu_do(id, menu_name, 1, var_override, menu_def)
        end
    -- LNK_CLOSEMENU (40001): Clean up menu state
    elseif num == CONST.LNK_CLOSEMENU then
        menu_close(true)

    -- LNK_ADDMENU (40010): Store menu definition
    elseif num == CONST.LNK_ADDMENU then
        local success, menu_def = pcall(JSON.decode, str)
        if not success then
            return
        end

        if not menu_def.name then
            report_error("Failed to add anonymous menu")
            return
        end

        success, _ = add_validate(menu_def)

    -- LNK_DELMENU (40011): Remove menu definition
    elseif num == CONST.LNK_DELMENU then
        if str ~= "" then
            ll.LinksetDataDelete(CONST.MENU_PREFIX .. str)
        else  -- Delete all menus
            local keys = ll.LinksetDataFindKeys("^_\\.MENU\\.", 0, 0)
            for _, key in ipairs(keys) do
                ll.LinksetDataDelete(key)
            end
        end

    -- LNK_ADDREPL (40020): Update replacements
    elseif num == CONST.LNK_ADDREPL then
        local replacements = JSON.decode(str) or {}
        if type(replacements) == "table" then
            for key, value in pairs(replacements) do
                local clean_key = trim(tostring(key))
                if clean_key ~= "" then
                    if value == nil or value == "" then
                        REPLACEMENTS[clean_key] = nil
                    else
                        REPLACEMENTS[clean_key] = trim(tostring(value))
                    end
                end
            end
        end

    -- LNK_DELREPL (40021): Remove replacements
    elseif num == CONST.LNK_DELREPL then
        local keys_to_delete = JSON.decode(str) or {}
        if type(keys_to_delete) == "table" then
            for _, key in ipairs(keys_to_delete) do
                local clean_key = trim(tostring(key))
                if clean_key ~= "" then
                    REPLACEMENTS[clean_key] = nil
                end
            end
        end
    end
end

function listen(channel, name, id, message)
    -- Clean up previous listener
    if MENU_STACK.listen then
        ll.ListenRemove(MENU_STACK.listen)
        MENU_STACK.listen = nil
    end

    if (message == CONST.LBL_BLANK) then
        show_active_menu(id)
    elseif (message == CONST.LBL_CLOSE) then
        menu_close(true)
    elseif (message == CONST.LBL_BACK) then
        menu_page(id, -1)
    elseif (message == CONST.LBL_NEXT) then
        menu_page(id, 1)
    elseif (message == CONST.LBL_UP) then
        menu_pop(id)
    else 
        menu_process(id, message)
    end
end

function timer()
    menu_close(true)
    ll.SetTimerEvent(0)
end
