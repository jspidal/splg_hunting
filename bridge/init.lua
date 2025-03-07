local frameworks = {
    qbx_core = 'qbx',
    ox_core = 'ox',
}

local framework = frameworks[require 'config.shared'?.Framework]
local duplicity = IsDuplicityVersion() and 'server' or 'client'


local FrameworkBridge = require ('bridge.%s.%s'):format(framework, duplicity)

return FrameworkBridge