--[[
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
if not Player then
    Player = Players.PlayerAdded:Wait()
end

local playerGui = Player:FindFirstChild("PlayerGui") or Player:WaitForChild("PlayerGui")

local KeyReveliX = loadstring(game:HttpGet('https://raw.githubusercontent.com/nathzzi/Rift-Android/refs/heads/main/keyguardian/keyguardianlibrary.lua'))()
local trueData = "729b2d0813534812951c1ead7ee7e10a"
local falseData = "a9051db43f4e452fa47e4c81a0727cb6"

KeyReveliX.Set({
    publicToken = "e423a2fdba5842a68919e6f8fb714064",
    privateToken = "930ecef53c674a3bb5bca1576577716f",
    trueData = trueData,
    falseData = falseData,
})

local X = {} do
    X.Folder = "FW"

    function X:SetFolder(folder)
        self.Folder = folder
        self:BuildFolderTree()
    end

    function X:BuildFolderTree()
        local paths = {
            self.Folder,
            self.Folder .. "/KeySystemReveliX"
        }
        for _, path in ipairs(paths) do
            if not isfolder(path) then
                makefolder(path)
            end
        end

        local files = {
            "KeyReveliXDefault.txt",
            "KeyReveliXPremium.txt"
        }

        for _, fileName in ipairs(files) do
            if not isfile(self.Folder .. "/KeySystemReveliX/" .. fileName) then
                writefile(self.Folder .. "/KeySystemReveliX/" .. fileName, "")
            end
        end
    end

    X:BuildFolderTree()

    function X:SaveKey(key, isPremium)
        local fileName = isPremium and "KeyReveliXPremium.txt" or "KeyReveliXDefault.txt"
        writefile(self.Folder .. "/KeySystemReveliX/" .. fileName, key)
    end

    function X:GetSavedKey(isPremium)
        local fileName = isPremium and "KeyReveliXPremium.txt" or "KeyReveliXDefault.txt"
        if isfile(self.Folder .. "/KeySystemReveliX/" .. fileName) then
            return readfile(self.Folder .. "/KeySystemReveliX/" .. fileName)
        else
            return ""
        end
    end
end

local savedKeyDefault = X:GetSavedKey(false)
local savedKeyPremium = X:GetSavedKey(true)

if savedKeyDefault ~= "" then
    local response = KeyReveliX.validateDefaultKey(savedKeyDefault)
    if response == trueData then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FeliciaXxxTop/ReveliX/refs/heads/main/TestUI.lua"))()
        return
    end
end

if savedKeyPremium ~= "" then
    local premiumResponse = KeyReveliX.validatePremiumKey(savedKeyPremium)
    if premiumResponse == trueData then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FeliciaXxxTop/ReveliX/refs/heads/main/TestUI.lua"))()
        return
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = playerGui
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 210)  
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true  
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 0, 0) 
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "ReveliX"
Title.TextColor3 = Color3.fromRGB(180, 180, 180) 
Title.TextSize = 20
local Line = Instance.new("Frame")
Line.Parent = Frame
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
Line.Position = UDim2.new(0, 0, 0, 30)
Line.Size = UDim2.new(1, 0, 0, 1)
Line.BorderSizePixel = 0
local MessageLabel = Instance.new("TextLabel")
MessageLabel.Parent = Frame
MessageLabel.BackgroundTransparency = 1
MessageLabel.Position = UDim2.new(0.1, 0, 0.22, 0) 
MessageLabel.Size = UDim2.new(0.8, 0, 0, 50)  
MessageLabel.Font = Enum.Font.Gotham
MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
MessageLabel.TextSize = 14
MessageLabel.Text = "Please get a key to activate ReveliX. Good luck!"
MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
MessageLabel.TextWrapped = true  
local EnterKeyBox = Instance.new("TextBox")
EnterKeyBox.Parent = Frame
EnterKeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
EnterKeyBox.Position = UDim2.new(0.1, 0, 0.40, 0)
EnterKeyBox.Size = UDim2.new(0.8, 0, 0, 30)
EnterKeyBox.Font = Enum.Font.Gotham
EnterKeyBox.Text = ""
EnterKeyBox.TextColor3 = Color3.fromRGB(220, 220, 220)
EnterKeyBox.TextSize = 14
EnterKeyBox.TextWrapped = true  
EnterKeyBox.TextXAlignment = Enum.TextXAlignment.Center 
EnterKeyBox.TextYAlignment = Enum.TextYAlignment.Center 
EnterKeyBox.PlaceholderText = "Enter your key here..."
EnterKeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
local EnterKeyBoxUICorner = Instance.new("UICorner", EnterKeyBox)
EnterKeyBoxUICorner.CornerRadius = UDim.new(0, 5)
local ResultLabel = Instance.new("TextLabel")
ResultLabel.Parent = Frame
ResultLabel.BackgroundTransparency = 1
ResultLabel.Position = UDim2.new(0.1, 0, 0.55, 0)  
ResultLabel.Size = UDim2.new(0.8, 0, 0, 25)
ResultLabel.Font = Enum.Font.GothamBold
ResultLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
ResultLabel.TextSize = 14
ResultLabel.Text = ""
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Parent = Frame
GetKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
GetKeyButton.Position = UDim2.new(0.1, 0, 0.70, 0)  
GetKeyButton.Size = UDim2.new(0.35, 0, 0, 30)
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.Text = "Get Key"
GetKeyButton.TextColor3 = Color3.fromRGB(180, 180, 180)
GetKeyButton.TextSize = 14
local GetKeyUICorner = Instance.new("UICorner", GetKeyButton)
GetKeyUICorner.CornerRadius = UDim.new(0, 5)
local CheckKeyButton = Instance.new("TextButton")
CheckKeyButton.Parent = Frame
CheckKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CheckKeyButton.Position = UDim2.new(0.55, 0, 0.70, 0)  
CheckKeyButton.Size = UDim2.new(0.35, 0, 0, 30)
CheckKeyButton.Font = Enum.Font.GothamBold
CheckKeyButton.Text = "Check Key"
CheckKeyButton.TextColor3 = Color3.fromRGB(180, 180, 180)
CheckKeyButton.TextSize = 14
local CheckKeyUICorner = Instance.new("UICorner", CheckKeyButton)
CheckKeyUICorner.CornerRadius = UDim.new(0, 5)
local DiscordButton = Instance.new("TextButton")
DiscordButton.Parent = Frame
DiscordButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DiscordButton.Position = UDim2.new(0.1, 0, 0.865, 0)
DiscordButton.Size = UDim2.new(0.8, 0, 0, 30)
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.Text = "Join Discord"
DiscordButton.TextColor3 = Color3.fromRGB(180, 180, 180)
DiscordButton.TextSize = 14
local DiscordUICorner = Instance.new("UICorner", DiscordButton)
DiscordUICorner.CornerRadius = UDim.new(0, 5)
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 3)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.BorderSizePixel = 0
local CloseButtonUICorner = Instance.new("UICorner", CloseButton)
CloseButtonUICorner.CornerRadius = UDim.new(0, 5)
CloseButton.MouseButton1Click:Connect(function()
    Frame:Destroy()
end)
GetKeyButton.MouseButton1Click:Connect(function()
    local Succ = pcall(function()
        setclipboard(KeyReveliX.getLink())
        ResultLabel.Text = "Key link copied!"
        ResultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    end)
end)

CheckKeyButton.MouseButton1Click:Connect(function()
    local key = EnterKeyBox.Text
    if key == "" then
        ResultLabel.Text = "Please enter a key."
        ResultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    else
        local response = KeyReveliX.validateDefaultKey(key)
        if response == trueData then
            ResultLabel.Text = "Valid Key!"
            ResultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            X:SaveKey(key)  
            task.wait()
            Frame:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FeliciaXxxTop/ReveliX/refs/heads/main/TestUI.lua"))()
        else
            local premiumResponse = KeyReveliX.validatePremiumKey(key)
            if premiumResponse == trueData then
                ResultLabel.Text = "Valid Premium Key!"
                ResultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                X:SaveKey(key)  
                task.wait()
                Frame:Destroy()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/FeliciaXxxTop/ReveliX/refs/heads/main/TestUI.lua"))()
            else
                ResultLabel.Text = "Invalid Key!"
                ResultLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end)
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/GjEhaYynVb")
    ResultLabel.Text = "Discord link copied!"
    ResultLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end)
]]--

loadstring(game:HttpGet("https://raw.githubusercontent.com/FeliciaXxxTop/ReveliX/refs/heads/main/TestUI.lua"))()
