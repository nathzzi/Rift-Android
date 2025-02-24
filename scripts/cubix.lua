local player = game.Players.LocalPlayer
while not player do
    task.wait()
    player = game.Players.LocalPlayer
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV199/Cubix/refs/heads/main/Cubix_Ui.lua"))()
