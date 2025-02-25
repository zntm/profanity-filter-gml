global.profanity_char = [
    "\@4", "a",
    "\$5", "s",
    "3", "e",
    "\!1\|", "i",
    "0", "o",
    "7\+", "t",
    "8", "b",
    "6", "g",
    "9", "g",
    "0", "o",
    "#", "h"
];

global.profanity_char_keys = "";

for (var i = 0; i < array_length(global.profanity_char) / 2; ++i)
{
    global.profanity_char_keys[@ i] = global.profanity_char[i * 2];
}

global.profanity_extreme = [];
global.profanity_extreme_unique_length = [];

global.profanity_regular = [];
global.profanity_regular_unique_length = [];

function init_scunthorpe(_type)
{
    static __init = function(_name, _unique_name, _directory)
    {
        var _buffer = buffer_load(_directory);
        
        var _data = array_unique(string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n"));
        
        array_sort(_data, sort_string_length);
        
        var _unique_length = -1;
        var _unique_length_index = 0;
        
        var _length = array_length(_data);
        
        array_resize(global[$ _name], _length)
        
        for (var i = 0; i < _length; ++i)
        {
            var _profanity = _data[i];
            var _profanity_length = string_length(_profanity);
            
            if (_profanity_length != _unique_length)
            {
                global[$ _unique_name][@ _unique_length_index++] = (_profanity_length << 32) | i;
            }
            
            global[$ _name][@ i] = _profanity;
        }
        
        buffer_delete(_buffer);
    }
    
    if (!directory_exists($"scunthorpe/{_type}/"))
    {
        array_resize(global.profanity_extreme, 0);
        array_resize(global.profanity_regular, 0);
        
        exit;
    }
    
    if (file_exists($"scunthorpe/{_type}/extreme.dic"))
    {
        __init("profanity_extreme", "profanity_extreme_unique_length", $"scunthorpe/{_type}/extreme.dic");
    }
    else
    {
        array_resize(global.profanity_extreme, 0);
    }
    
    if (file_exists($"scunthorpe/{_type}/regular.dic"))
    {
        __init("profanity_regular", "profanity_regular_unique_length", $"scunthorpe/{_type}/regular.dic");
    }
    else
    {
        array_resize(global.profanity_regular, 0);
    }
    
    show_debug_message(global.profanity_extreme_unique_length)
}