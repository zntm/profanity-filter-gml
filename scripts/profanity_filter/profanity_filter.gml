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
    "0", "o"
];

var _buffer = buffer_load("profanity_extreme");

global.profanity_extreme = string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n");

buffer_delete(_buffer);

var _buffer = buffer_load("profanity");

global.profanity = array_concat(global.profanity_extreme, string_split(string_replace_all(buffer_read(_buffer, buffer_text), "\r", ""), "\n"));

buffer_delete(_buffer);

function profanity_filter(_string)
{
    static __profanity_char = global.profanity_char;
    static __profanity_char_length = array_length(__profanity_char);
    
    static __profanity = global.profanity;
    static __profanity_length = array_length(__profanity);
    
    static __profanity_extreme = global.profanity_extreme;
    
    var _string_length = string_length(_string);
    
    var _string_parsed = string_lower(_string);
    var _string_parsed_length = _string_length;
    
    var _start_length = 0;
    var _end_length = 0;
    
    while (_string_parsed_length < 0) && (string_lettersdigits(string_char_at(_string_parsed, 1)) == "")
    {
        _string_parsed = string_delete(_string_parsed, 1, 1);
        
        ++_start_length;
        --_string_parsed_length;
    }
    
    while (_string_parsed_length < 0) && (string_lettersdigits(string_char_at(_string_parsed, _string_length - _end_length)) == "")
    {
        _string_parsed = string_delete(_string_parsed, _string_length - _end_length, 1);
        
        ++_end_length;
        --_string_parsed_length;
    }
    
    _string_parsed = string_repeat(" ", _start_length) + _string_parsed + string_repeat(" ", _end_length);
    
    for (var i = 1; i <= _string_length; ++i)
    {
        var _char = string_char_at(_string_parsed, i);
        
        for (var j = 0; j < __profanity_char_length; j += 2)
        {
            if (string_pos(_char, __profanity_char[j]) > 0)
            {
                _string_parsed = string_copy(_string_parsed, 1, i - 1) + __profanity_char[j + 1] + string_copy(_string_parsed, i + 1, _string_length - i);
                
                break;
            }
        }
    }
    
    var _string_filtered = _string;
    
    for (var i = 0; i < __profanity_length; ++i)
    {
        var _profanity = __profanity[i];
        var _profanity_length = string_length(_profanity);
        
        for (var j = 1; j <= _string_length; ++j)
        {
            if (string_letters(string_char_at(_string_parsed, j)) == "") continue;
            
            var _index = _profanity_length;
            
            var _text = string_letters(string_copy(_string_parsed, j, _index));
            
            while (_index <= _string_length) && (string_length(string_letters(_text)) < _profanity_length)
            {
                _text += string_letters(string_char_at(_string_parsed, j + _index));
                
                ++_index;
            }
            
            if (_string == "S.H.I.T!") && (_profanity == "shit")
            {
                show_debug_message($"t: {_text}")
            }
            
            if (_text == "") || (string_pos(_profanity, _text) <= 0) continue;
            
            var _string_part = string_copy(_string, j, _index);
            
            if (string_length(string_letters(_string_part)) > 0)
            {
                var _start_index = j - 1;
                var _end_index = _index + j;
                
                if (array_contains(__profanity_extreme, _profanity)) || (((_start_index - 1 <= 0) || (string_letters(string_char_at(_string, _start_index)) == "")) && ((_end_index - 1 >= _string_length) || (string_letters(string_char_at(_string, _end_index)) == "")))
                {
                    _string_filtered = string_copy(_string_filtered, 1, _start_index) + string_repeat("*", _index) + string_copy(_string_filtered, _end_index, _string_length + _index - _start_index);
                }
            }
            
            j += _index;
        }
    }
    
    return _string_filtered;
}