--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
local colors = {
    AliceBlue           = {0.941177, 0.972549, 1.000000},    AntiqueWhite        = {0.980392, 0.921569, 0.843137},
    Aqua                = {0.000000, 1.000000, 1.000000},    Aquamarine          = {0.498039, 1.000000, 0.831373},
    Azure               = {0.941177, 1.000000, 1.000000},    Beige               = {0.960784, 0.960784, 0.862745},
    Bisque              = {1.000000, 0.894118, 0.768628},    Black               = {0.000000, 0.000000, 0.000000},
    BlanchedAlmond      = {1.000000, 0.921569, 0.803922},    Blue                = {0.000000, 0.000000, 1.000000},
    BlueViolet          = {0.541177, 0.168628, 0.886275},    Brown               = {0.647059, 0.164706, 0.164706},
    BurlyWood           = {0.870588, 0.721569, 0.529412},    CadetBlue           = {0.372549, 0.619608, 0.627451},
    Chartreuse          = {0.498039, 1.000000, 0.000000},    Chocolate           = {0.823529, 0.411765, 0.117647},
    Coral               = {1.000000, 0.498039, 0.313726},    CornflowerBlue      = {0.392157, 0.584314, 0.929412},
    Cornsilk            = {1.000000, 0.972549, 0.862745},    Crimson             = {0.862745, 0.078431, 0.235294},
    Cyan                = {0.000000, 1.000000, 1.000000},    DarkBlue            = {0.000000, 0.000000, 0.545098},
    DarkCyan            = {0.000000, 0.545098, 0.545098},    DarkGoldenrod       = {0.721569, 0.525490, 0.043137},
    DarkGray            = {0.662745, 0.662745, 0.662745},    DarkGrey            = {0.662745, 0.662745, 0.662745},
    DarkGreen           = {0.000000, 0.392157, 0.000000},    DarkKhaki           = {0.741177, 0.717647, 0.419608},
    DarkMagenta         = {0.545098, 0.000000, 0.545098},    DarkOliveGreen      = {0.333333, 0.419608, 0.184314},
    DarkOrange          = {1.000000, 0.549020, 0.000000},    DarkOrchid          = {0.600000, 0.196078, 0.800000},
    DarkRed             = {0.545098, 0.000000, 0.000000},    DarkSalmon          = {0.913726, 0.588235, 0.478431},
    DarkSeaGreen        = {0.560784, 0.737255, 0.560784},    DarkSlateBlue       = {0.282353, 0.239216, 0.545098},
    DarkSlateGray       = {0.184314, 0.309804, 0.309804},    DarkSlateGrey       = {0.184314, 0.309804, 0.309804},
    DarkTurquoise       = {0.000000, 0.807843, 0.819608},    DarkViolet          = {0.580392, 0.000000, 0.827451},
    DeepPink            = {1.000000, 0.078431, 0.576471},    DeepSkyBlue         = {0.000000, 0.749020, 1.000000},
    DimGray             = {0.411765, 0.411765, 0.411765},    DimGrey             = {0.411765, 0.411765, 0.411765},
    DodgerBlue          = {0.117647, 0.564706, 1.000000},    FireBrick           = {0.698039, 0.133333, 0.133333},
    FloralWhite         = {1.000000, 0.980392, 0.941177},    ForestGreen         = {0.133333, 0.545098, 0.133333},
    Fuchsia             = {1.000000, 0.000000, 1.000000},    Gainsboro           = {0.862745, 0.862745, 0.862745},
    GhostWhite          = {0.972549, 0.972549, 1.000000},    Gold                = {1.000000, 0.843137, 0.000000},
    Goldenrod           = {0.854902, 0.647059, 0.125490},    Grey                = {0.501961, 0.501961, 0.501961},
    Green               = {0.000000, 0.501961, 0.000000},    GreenYellow         = {0.678431, 1.000000, 0.184314},
    Honeydew            = {0.941177, 1.000000, 0.941177},    HotPink             = {1.000000, 0.411765, 0.705882},
    IndianRed           = {0.803922, 0.360784, 0.360784},    Indigo              = {0.294118, 0.000000, 0.509804},
    Ivory               = {1.000000, 1.000000, 0.941177},    Khaki               = {0.941177, 0.901961, 0.549020},
    Lavender            = {0.901961, 0.901961, 0.980392},    LavenderBlush       = {1.000000, 0.941177, 0.960784},
    LawnGreen           = {0.486275, 0.988235, 0.000000},    LemonChiffon        = {1.000000, 0.980392, 0.803922},
    LightBlue           = {0.678431, 0.847059, 0.901961},    LightCoral          = {0.941177, 0.501961, 0.501961},
    LightCyan           = {0.878431, 1.000000, 1.000000},    LightGoldenrodYellow= {0.980392, 0.980392, 0.823529},
    LightGray           = {0.827451, 0.827451, 0.827451},    LightGrey           = {0.827451, 0.827451, 0.827451},
    LightGreen          = {0.564706, 0.933333, 0.564706},    LightPink           = {1.000000, 0.713726, 0.756863},
    LightSalmon         = {1.000000, 0.627451, 0.478431},    LightSeaGreen       = {0.125490, 0.698039, 0.666667},
    LightSkyBlue        = {0.529412, 0.807843, 0.980392},    LightSlateGray      = {0.466667, 0.533333, 0.600000},
    LightSlateGrey      = {0.466667, 0.533333, 0.600000},    LightSteelBlue      = {0.690196, 0.768628, 0.870588},
    LightYellow         = {1.000000, 1.000000, 0.878431},    Lime                = {0.000000, 1.000000, 0.000000},
    LimeGreen           = {0.196078, 0.803922, 0.196078},    Linen               = {0.980392, 0.941177, 0.901961},
    Magenta             = {1.000000, 0.000000, 1.000000},    Maroon              = {0.501961, 0.000000, 0.000000},
    MediumAquamarine    = {0.400000, 0.803922, 0.666667},    MediumBlue          = {0.000000, 0.000000, 0.803922},
    MediumOrchid        = {0.729412, 0.333333, 0.827451},    MediumPurple        = {0.576471, 0.439216, 0.858824},
    MediumSeaGreen      = {0.235294, 0.701961, 0.443137},    MediumSlateBlue     = {0.482353, 0.407843, 0.933333},
    MediumSpringGreen   = {0.000000, 0.980392, 0.603922},    MediumTurquoise     = {0.282353, 0.819608, 0.800000},
    MediumVioletRed     = {0.780392, 0.082353, 0.521569},    MidnightBlue        = {0.098039, 0.098039, 0.439216},
    MintCream           = {0.960784, 1.000000, 0.980392},    MistyRose           = {1.000000, 0.894118, 0.882353},
    Moccasin            = {1.000000, 0.894118, 0.709804},    NavajoWhite         = {1.000000, 0.870588, 0.678431},
    Navy                = {0.000000, 0.000000, 0.501961},    OldLace             = {0.992157, 0.960784, 0.901961},
    Olive               = {0.501961, 0.501961, 0.000000},    OliveDrab           = {0.419608, 0.556863, 0.137255},
    Orange              = {1.000000, 0.647059, 0.000000},    OrangeRed           = {1.000000, 0.270588, 0.000000},
    Orchid              = {0.854902, 0.439216, 0.839216},    PaleGoldenrod       = {0.933333, 0.909804, 0.666667},
    PaleGreen           = {0.596079, 0.984314, 0.596079},    PaleTurquoise       = {0.686275, 0.933333, 0.933333},
    PaleVioletRed       = {0.858824, 0.439216, 0.576471},    PapayaWhip          = {1.000000, 0.937255, 0.835294},
    PeachPuff           = {1.000000, 0.854902, 0.725490},    Peru                = {0.803922, 0.521569, 0.247059},
    Pink                = {1.000000, 0.752941, 0.796078},    Plum                = {0.866667, 0.627451, 0.866667},
    PowderBlue          = {0.690196, 0.878431, 0.901961},    Purple              = {0.501961, 0.000000, 0.501961},
    Red                 = {1.000000, 0.000000, 0.000000},    RosyBrown           = {0.737255, 0.560784, 0.560784},
    RoyalBlue           = {0.254902, 0.411765, 0.882353},    SaddleBrown         = {0.545098, 0.270588, 0.074510},
    Salmon              = {0.980392, 0.501961, 0.447059},    SandyBrown          = {0.956863, 0.643137, 0.376471},
    SeaGreen            = {0.180392, 0.545098, 0.341177},    Seashell            = {1.000000, 0.960784, 0.933333},
    Sienna              = {0.627451, 0.321569, 0.176471},    Silver              = {0.752941, 0.752941, 0.752941},
    SkyBlue             = {0.529412, 0.807843, 0.921569},    SlateBlue           = {0.415686, 0.352941, 0.803922},
    SlateGray           = {0.439216, 0.501961, 0.564706},    SlateGrey           = {0.439216, 0.501961, 0.564706},
    Snow                = {1.000000, 0.980392, 0.980392},    SpringGreen         = {0.000000, 1.000000, 0.498039},
    SteelBlue           = {0.274510, 0.509804, 0.705882},    Tan                 = {0.823529, 0.705882, 0.549020},
    Teal                = {0.000000, 0.501961, 0.501961},    Thistle             = {0.847059, 0.749020, 0.847059},
    Tomato              = {1.000000, 0.388235, 0.278431},    Turquoise           = {0.250980, 0.878431, 0.815686},
    Violet              = {0.933333, 0.509804, 0.933333},    Wheat               = {0.960784, 0.870588, 0.701961},
    White               = {1.000000, 1.000000, 1.000000},    WhiteSmoke          = {0.960784, 0.960784, 0.960784},
    Yellow              = {1.000000, 1.000000, 0.000000},    YellowGreen         = {0.603922, 0.803922, 0.196078},
}

--------------------------------------------------------------------------------
local hues = {
    Red = {         
        "Misty Rose",           "Salmon",               "Snow",                 
        "Light Coral",          "Rosy Brown",           "Indian Red",           
        "Red",                  "Brown",                "Fire Brick",           
        "Dark Red",             "Maroon",               "Light Pink",           
        "Pink",                 "Crimson",              "Lavender Blush",       
        "Pale Violet Red",      "Hot Pink",             "Deep Pink",            
        "Medium Violet Red"       
    },
    Purple = {
        "Orchid",               "Thistle",              "Plum",                 
        "Violet",               "Magenta",              "Fuchsia",              
        "Dark Magenta",         "Purple",               "Medium Orchid",         
        "Dark Violet",          "Dark Orchid",          "Indigo",               
        "Blue Violet",          "Medium Purple",        "Medium Slate Blue",      
        "Slate Blue",           "Dark Slate Blue",      "Lavender"              
    },
    Blue = {        
        "Ghost White",          "Blue",                 "Medium Blue",           
        "Midnight Blue",        "Dark Blue",            "Navy",                 
        "Royal Blue",           "Cornflower Blue",      "Light Steel Blue",       
        "Light Slate Grey",     "Slate Grey",           "Dodger Blue",           
        "Alice Blue",           "Steel Blue",           "Light Sky Blue",         
        "Sky Blue",             "Deep Sky Blue",        "Light Blue",            
        "Powder Blue",          "Cadet Blue",           "Azure",                
        "Light Cyan",           "Pale Turquoise",       "Cyan",                 
        "Aqua",                 "Dark Turquoise",       "Dark Slate Grey"       
    },
    Green = {
        "Dark Cyan",            "Teal",                 "Medium Turquoise",      
        "Light Sea Green",      "Turquoise",            "Aquamarine",           
        "Medium Aquamarine",    "Medium Spring Green",  "Mint Cream",           
        "Spring Green",         "Medium Sea Green",     "Sea Green",             
        "Honeydew",             "Light Green",          "Pale Green",            
        "Dark Sea Green",       "Lime Green",           "Lime",                 
        "Forest Green",         "Green",                "Dark Green",            
        "Chartreuse",           "Lawn Green",           "Green Yellow",          
        "Dark Olive Green",     "Yellow Green",         "Olive Drab"            
    },
    Yellow = {
        "Beige",                "Light Goldenrod Yellow","Ivory",                
        "Light Yellow",         "Yellow",               "Olive",                
        "Dark Khaki",           "Lemon Chiffon",        "Pale Goldenrod",        
        "Khaki",                "Gold",                 "Cornsilk",             
        "Goldenrod",            "Dark Goldenrod",       "Floral White",          
        "Old Lace"               
    },
    Orange = {
        "Wheat",                "Moccasin",             "Orange",               
        "Papaya Whip",          "Blanched Almond",      "Navajo White",         
        "Antique White",        "Tan",                  "Burly Wood",            
        "Bisque",               "Dark Orange",          "Linen",                
        "Peru",                 "Peach Puff",           "Sandy Brown",           
        "Chocolate",            "Saddle Brown",         "Seashell",             
        "Sienna",               "Light Salmon",         "Coral",                
        "Orange Red",           "Dark Salmon",          "Tomato"                
    },
    Gray = {
        "White",                "White Smoke",          "Gainsboro",            
        "Light Grey",           "Silver",               "Dark Grey",            
        "Grey",                 "Dim Grey",             "Black"                 
    }
}

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

--------------------------------------------------------------------------------
-- Revised build_color_menu using the menu definition style from Menu Controller.lua
local function build_color_menu()
    local menu_def = {
        name = "color_menu",
        type = "CMD",
        msg  = "Current color is {COLOR_NAME}\nSelect a color:",
        var = "COLOR_NAME",
        btns = {}
    }

    -- Iterate over hues to create submenus for each hue group
    for hue, color_list in pairs(hues) do
        local button_def = {
            type  = "OPT",
            label = hue .. " Hues",
            opts = {}
        }

        local options = {}
        for _, color_name in pairs(color_list) do
            table.insert(options, {name = color_name, val = color_name:gsub("%s+", "")})
        end
        if #options then
            button_def.opts = options
            table.insert(menu_def.btns, button_def)
        end
    end
    return menu_def
end

--------------------------------------------------------------------------------

-- New function to find the nearest color given an array {r, g, b}
local function find_nearest_color(input_color)
    local best_name = nil
    local best_diff = math.huge
    for name, rgb in pairs(colors) do
        local dr = input_color[1] - rgb[1]
        local dg = input_color[2] - rgb[2]
        local db = input_color[3] - rgb[3]
        local diff = dr * dr + dg * dg + db * db
        if diff < best_diff then
            best_diff = diff
            best_name = name
        end
    end
    return best_name
end

--------------------------------------------------------------------------------
function linkset_data(action, name, value)
    if action == 1 then
        if name == "COLOR_NAME" then
            local color = colors[value]
            if color then
                ll.Say(0, "Color set to " .. value)
                ll.SetColor(vector(color[1], color[2], color[3]), ALL_SIDES)
                ll.SetText("Color is now " .. value .. "\nTouch to change.", vector(color[1], color[2], color[3]), 1.0)
            end
        else
            ll.Say(0, "Changed " .. name )
        end
    end
end

function touch_start(count)
    ll.MessageLinked(-1, 40000, "color_menu", ll.DetectedKey(0))
end
--------------------------------------------------------------------------------

--ll.MessageLinked(LINK_SET, 40010, JSON.encode(build_color_menu()), NULL_KEY)
ll.LinksetDataWrite("_.MENU.color_menu", JSON.encode(build_color_menu()))
--------------------------------------------------------------------------------
ll.Say(0, "Script loaded " .. ll.GetUsedMemory() .. " bytes used")
