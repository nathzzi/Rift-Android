setreadonly(client, false);
client.enableautoexec()
setreadonly(client, true);

repeat task.wait until game:IsLoaded()
loadstring(game:HttpGet("https://zomex.lol/ui.lua"))()
