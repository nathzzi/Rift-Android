setreadonly(client, false);
client.enableautoexec()
setreadonly(client, true);

repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet('https://raw.githubusercontent.com/nyazs/AureliaUI/refs/heads/main/ui'))()
