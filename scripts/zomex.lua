setreadonly(client, false);
client.enableautoexec()
setreadonly(client, true);
print("test")

repeat task.wait() until game:IsLoaded()
print("test2")
loadstring(game:HttpGet("https://zomex.lol/ui.lua"))()
