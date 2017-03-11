
local config = require 'config'

local discordia = require 'discordia'
local client = discordia.Client()

client.voice:loadOpus('libopus')
client.voice:loadSodium('libsodium')

local con

local sound_commands = {
  ["!mesto"] = "sounds/mesto.ogg",
  ["!n"] = "sounds/messer.ogg",
  ["!dopust"] = "sounds/dopust.ogg",
  ["!obvezno"] = "sounds/dopust.ogg",
  ["!rep"] = "sounds/rep.ogg",
  ["!gorice"] = "sounds/gorice.ogg",
  ["!zenska"] = "sounds/zenska.ogg",
  ["!oproste"] = "sounds/oproste.ogg",
  ["!idk"] = "sounds/idk.ogg",
  ["!tak"] = "sounds/tak.ogg",
  ["!zamene"] = "sounds/zamene.ogg",
  ["!hihi"] = "sounds/hihi.ogg",
  ["!vrag"] = "sounds/vrag.ogg",
}

client:on('ready', function ()
  print('Nandek online!')
end)

client:on('messageCreate', function (msg)
  if msg.content == '!nandek' then
    con = msg.member.voiceChannel:join()
    msg.channel:sendMessage('Zdravo, jaz sen Nandek. V slűžbo z nožon al pa domu!')
  elseif msg.content == "!komande" then
    local commands = {}
    for k,_ in pairs(sound_commands) do
      table.insert(commands,k)
    end
    local str = table.concat(commands, "\n")
    msg.channel:sendMessage(str)
  elseif sound_commands[msg.content] ~= nil then
    if msg.member and msg.member.voiceChannel then
      if con and (not con.isPlaying) then
        return con:playFile(sound_commands[msg.content])
      end
    end
    return msg:reply('Gužva v Lotmerki, nesen moga kcoj.')
  end
end)

client:on('voiceChannelLeave', function (member, channel)
  local con = channel:join()
  return con:playFile("sounds/rep.ogg")
end)

client:run(config.token)
