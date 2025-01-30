local Rift = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local BGFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Cheat = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local Execute = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Clear = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Paste = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")

Rift.Name = "Rift"
Rift.Parent = game:GetService("CoreGui")
Rift.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Rift.ResetOnSpawn = false

Main.Name = "Main"
Main.Parent = Rift
Main.BackgroundColor3 = Color3.new(0.0117647, 0.0117647, 0.0117647)
Main.BorderColor3 = Color3.new(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.111389235, 0, 0.133139953, 0)
Main.Size = UDim2.new(0, 368, 0, 262)
Main.Active = true
Main.Draggable = true

BGFrame.Name = "BGFrame"
BGFrame.Parent = Main
BGFrame.BackgroundColor3 = Color3.new(0.0705882, 0.0705882, 0.0705882)
BGFrame.BorderColor3 = Color3.new(0, 0, 0)
BGFrame.BorderSizePixel = 0
BGFrame.Position = UDim2.new(0.040760871, 0, 0.0801526681, 0)
BGFrame.Size = UDim2.new(0, 337, 0, 173)

UICorner.Parent = BGFrame

Cheat.Name = "Cheat"
Cheat.Parent = BGFrame
Cheat.BackgroundColor3 = Color3.new(1, 1, 1)
Cheat.BackgroundTransparency = 1
Cheat.BorderColor3 = Color3.new(0, 0, 0)
Cheat.BorderSizePixel = 0
Cheat.Position = UDim2.new(0.0213390309, 0, 0, 0)
Cheat.Size = UDim2.new(0, 329, 0, 173)
Cheat.ClearTextOnFocus = false
Cheat.Font = Enum.Font.SourceSans
Cheat.MultiLine = true
Cheat.PlaceholderText = "Start typing your script here..."
Cheat.Text = ""
Cheat.TextColor3 = Color3.new(1, 1, 1)
Cheat.TextSize = 10
Cheat.TextWrapped = true
Cheat.TextXAlignment = Enum.TextXAlignment.Left
Cheat.TextYAlignment = Enum.TextYAlignment.Top

UICorner_2.Parent = Main

Execute.Name = "Execute"
Execute.Parent = Main
Execute.BackgroundColor3 = Color3.new(0.0627451, 1, 0.329412)
Execute.BorderColor3 = Color3.new(0, 0, 0)
Execute.BorderSizePixel = 0
Execute.Position = UDim2.new(0.040760871, 0, 0.790076315, 0)
Execute.Size = UDim2.new(0, 104, 0, 42)
Execute.Font = Enum.Font.Cartoon
Execute.Text = "Execute"
Execute.TextColor3 = Color3.new(0, 0, 0)
Execute.TextSize = 19
Execute.TextWrapped = true

UICorner_3.Parent = Execute

Clear.Name = "Clear"
Clear.Parent = Main
Clear.BackgroundColor3 = Color3.new(0.890196, 0, 0)
Clear.BorderColor3 = Color3.new(0, 0, 0)
Clear.BorderSizePixel = 0
Clear.Position = UDim2.new(0.345108688, 0, 0.790076315, 0)
Clear.Size = UDim2.new(0, 79, 0, 42)
Clear.Font = Enum.Font.Cartoon
Clear.Text = "Clear"
Clear.TextColor3 = Color3.new(0, 0, 0)
Clear.TextSize = 19
Clear.TextWrapped = true

UICorner_4.Parent = Clear

Paste.Name = "Paste"
Paste.Parent = Main
Paste.BackgroundColor3 = Color3.new(0.890196, 0.627451, 0.0156863)
Paste.BorderColor3 = Color3.new(0, 0, 0)
Paste.BorderSizePixel = 0
Paste.Position = UDim2.new(0.741847813, 0, 0.790076315, 0)
Paste.Size = UDim2.new(0, 79, 0, 42)
Paste.Font = Enum.Font.Cartoon
Paste.Text = "Paste"
Paste.TextColor3 = Color3.new(0, 0, 0)
Paste.TextSize = 19
Paste.TextWrapped = true

UICorner_5.Parent = Paste

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.225543484, 0, 0, 0)
Title.Size = UDim2.new(0, 200, 0, 21)
Title.Font = Enum.Font.Ubuntu
Title.Text = "Rift"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14

Execute.MouseButton1Click:Connect(function()
    local scriptText = Cheat.Text
    loadstring(scriptText)()
end)

Clear.MouseButton1Click:Connect(function()
    Cheat.Text = ""
end)

Paste.MouseButton1Click : Connect(function()
    Cheat.Text = getclipboard()
end)
