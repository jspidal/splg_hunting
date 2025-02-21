local framework = require 'config.shared'?.Framework
local duplicity = IsDuplicityVersion() and 'server' or 'client'

local FrameworkBridge = require ('bridge.%s.%s'):format(framework, duplicity)

return FrameworkBridge