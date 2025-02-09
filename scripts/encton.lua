setreadonly(client, false);
client.enableautoexec()
setreadonly(client, true);

repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BatuKvi123/Encton/refs/heads/main/EnctonSource"))() 
wait(1)
game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "Encton Android",
    Text = "This cheat is powered by Rift Android",
    Icon = "rbxassetid://135123682987938",
    Duration = 5
})
