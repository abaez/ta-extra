--- the initializer for extend module.
-- Adds a number of snippets and extensions to different languages.
-- @author [Alejandro Baez](https://twitter.com/a_baez)

local M = {}
for filename in lfs.dir(_USERHOME..'/modules/extra/') do
  if filename:find('%.lua$') and filename ~= 'init.lua' then
    -- using the name of the module as the key. ;)
    local key = filename:match('^(.+)%.lua$')
    M[key] = require('extra.'..key)
  end
end

events.connect(events.LEXER_LOADED, function(lang)
  if M[lang] == nil then return end

  if M[lang].connecting ~= nil then
    M[lang].connecting()
  end

  if type(snippets) == 'table' and M[lang].snipping ~= nil then
    if snippets[lang] == nil or #snippets[lang] ~= #M[lang].snipping then
      snippets[lang] = M[lang].snipping
    end
  end
end)

return {}
