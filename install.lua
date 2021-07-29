--[[
Change path to github location to pull from (for those who fork...)
Ensure you have the '/ at the end


]]
local path = "https://raw.githubusercontent.com/k3nw4y/auto-crossbreeding/"

local shell = require("shell")
local filesystem = require("filesystem")
local args = {...}
local scripts = {
    "action.lua",
    "database.lua",
    "gps.lua",
    "posUtil.lua",
    "scanner.lua",
    "signal.lua",
    "autoStat.lua",
    "autoCrossbreed.lua",
    "autoSpread.lua",
    "install.lua",
    "tasks.lua",
    "cleanup.lua",
    "autoFill.lua"
}

local function exists(filename)
    return filesystem.exists(shell.getWorkingDirectory().."/"..filename)
end

local branch
local option
if #args == 0 then
    branch = "main"
else
    branch = args[1]
end

if branch == "help" then
    print("Usage:\n./install or ./install [branch] [updateconfig]")
    return
end

if #args == 2 then
    option = args[2]
end

for i=1, #scripts do
    shell.execute("wget -f "..path..branch.."/"..scripts[i])
end

if not exists("config.lua") then
    shell.execute("wget "..path..branch.."/config.lua")
end

if option == "updateconfig" then
    if exists("config.lua") then
        if exists("config.bak") then
            shell.execute("rm config.bak")
        end
        shell.execute("mv config.lua config.bak")
        print("Moved config.lua to config.bak")
    end
    shell.execute("wget "..branch.."/config.lua")
end
