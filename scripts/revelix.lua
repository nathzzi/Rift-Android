game:GetService("StarterGui"):SetCore("SendNotification",{
Title = "Revelix has been discontinued!",
Text = "You’ll now be kicked.", 
Duration = 50
})
wait(5)
game:GetService("Players").LocalPlayer:Kick("Revelix Android has been discontinued");
