setreadonly(client, false);
client.enableautoexec()
setreadonly(client, true);

repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BatuKvi123/Encton/refs/heads/main/EnctonSource"))() 
