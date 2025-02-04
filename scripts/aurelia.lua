--loadstring(game:HttpGet('https://raw.githubusercontent.com/nyazs/AureliaUI/refs/heads/main/ui'))()
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScreenGui"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local AureliaBeta = Instance.new("Frame")
AureliaBeta.Name = "AureliaBeta"
AureliaBeta.Position = UDim2.new(0.309186, 0, 0.172858, 0)
AureliaBeta.Size = UDim2.new(0, 511, 0, 314)
AureliaBeta.BackgroundColor3 = Color3.new(0.054902, 0.054902, 0.054902)
AureliaBeta.BorderSizePixel = 0
AureliaBeta.BorderColor3 = Color3.new(0, 0, 0)
AureliaBeta.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.Name = "UICorner"

UICorner.Parent = AureliaBeta

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "ImageLabel"
ImageLabel.Position = UDim2.new(0.365949, 0, 0, 0)
ImageLabel.Size = UDim2.new(0, 61, 0, 60)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.BorderColor3 = Color3.new(0, 0, 0)
ImageLabel.Transparency = 1
ImageLabel.Image = "rbxassetid://100097767297004"
ImageLabel.Parent = AureliaBeta

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "TextLabel"
TextLabel.Position = UDim2.new(0.385519, 0, 0.0159236, 0)
TextLabel.Size = UDim2.new(0, 129, 0, 50)
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderSizePixel = 0
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.Transparency = 1
TextLabel.Text = "urelia"
TextLabel.TextColor3 = Color3.new(255, 255, 255)
TextLabel.TextSize = 20
TextLabel.FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel.Parent = AureliaBeta

local execframe = Instance.new("Frame")
execframe.Name = "execframe"
execframe.Position = UDim2.new(0, 0, 0.154037, 0)
execframe.Size = UDim2.new(0, 511, 0, 258)
execframe.BackgroundColor3 = Color3.new(0.0509804, 0.0509804, 0.121569)
execframe.BackgroundTransparency = 1
execframe.BorderSizePixel = 0
execframe.BorderColor3 = Color3.new(0, 0, 0)
execframe.ZIndex = 101
execframe.Transparency = 1
execframe.Parent = AureliaBeta

local UICorner2 = Instance.new("UICorner")
UICorner2.Name = "UICorner"

UICorner2.Parent = execframe

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(0, 511, 0, 215)
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.BorderColor3 = Color3.new(0, 0, 0)
ScrollingFrame.ZIndex = 101
ScrollingFrame.Transparency = 1
ScrollingFrame.Active = true
ScrollingFrame.ScrollBarImageTransparency = 0.8999999761581421
ScrollingFrame.Parent = execframe

local TextBox = Instance.new("ScrollingFrame")
TextBox.Name = "TextBox"
TextBox.Position = UDim2.new(0.0360657, 0, 3.63305e-07, 0)
TextBox.Size = UDim2.new(0.948087, 0, 4.27646, 0)
TextBox.BackgroundColor3 = Color3.new(0.145098, 0.145098, 0.145098)
TextBox.BackgroundTransparency = 1
TextBox.BorderColor3 = Color3.new(0.243137, 0.243137, 0.243137)
TextBox.ZIndex = 3
TextBox.Transparency = 1
TextBox.CanvasSize = UDim2.new(0, 908, 0, 180)
TextBox.ScrollBarThickness = 5
TextBox.BottomImage = "rbxassetid://148970562"
TextBox.MidImage = "rbxassetid://148970562"
TextBox.TopImage = "rbxassetid://148970562"
TextBox.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
TextBox.Parent = ScrollingFrame

local Source = Instance.new("TextBox")
Source.Name = "Source"
Source.Size = UDim2.new(1, 0, 1, 0)
Source.BackgroundColor3 = Color3.new(1, 1, 1)
Source.BackgroundTransparency = 1
Source.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Source.ZIndex = 3
Source.Transparency = 1
Source.Text = ""
Source.TextColor3 = Color3.new(255, 255, 255)
Source.TextSize = 15
Source.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Source.TextXAlignment = Enum.TextXAlignment.Left
Source.TextYAlignment = Enum.TextYAlignment.Top
Source.RichText = true
Source.ClearTextOnFocus = false
Source.MultiLine = true
Source.PlaceholderText = "--[[Aurelia(There is no offcial site for Aurelia)]]--"
Source.PlaceholderColor3 = Color3.new(0.8, 0.8, 0.8)
Source.Parent = TextBox

local Script = Instance.new("Script")
Script.Name = "Script"

Script.Parent = Source

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "RemoteEvent"

RemoteEvent.Parent = Source

local Tokens_ = Instance.new("TextLabel")
Tokens_.Name = "Tokens_"
Tokens_.Size = UDim2.new(1, 0, 1, 0)
Tokens_.BackgroundColor3 = Color3.new(1, 1, 1)
Tokens_.BackgroundTransparency = 1
Tokens_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Tokens_.ZIndex = 5
Tokens_.Transparency = 1
Tokens_.Text = ""
Tokens_.TextColor3 = Color3.new(255, 255, 255)
Tokens_.TextSize = 15
Tokens_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Tokens_.TextXAlignment = Enum.TextXAlignment.Left
Tokens_.TextYAlignment = Enum.TextYAlignment.Top
Tokens_.Parent = Source

local Numbers_ = Instance.new("TextLabel")
Numbers_.Name = "Numbers_"
Numbers_.Size = UDim2.new(1, 0, 1, 0)
Numbers_.BackgroundColor3 = Color3.new(1, 1, 1)
Numbers_.BackgroundTransparency = 1
Numbers_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Numbers_.ZIndex = 4
Numbers_.Transparency = 1
Numbers_.Text = ""
Numbers_.TextColor3 = Color3.new(255, 255, 255)
Numbers_.TextSize = 15
Numbers_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Numbers_.TextXAlignment = Enum.TextXAlignment.Left
Numbers_.TextYAlignment = Enum.TextYAlignment.Top
Numbers_.Parent = Source

local Keywords_ = Instance.new("TextLabel")
Keywords_.Name = "Keywords_"
Keywords_.Size = UDim2.new(1, 0, 1, 0)
Keywords_.BackgroundColor3 = Color3.new(1, 1, 1)
Keywords_.BackgroundTransparency = 1
Keywords_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Keywords_.ZIndex = 5
Keywords_.Transparency = 1
Keywords_.Text = ""
Keywords_.TextColor3 = Color3.new(255, 255, 255)
Keywords_.TextSize = 15
Keywords_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Keywords_.TextXAlignment = Enum.TextXAlignment.Left
Keywords_.TextYAlignment = Enum.TextYAlignment.Top
Keywords_.Parent = Source

local Globals_ = Instance.new("TextLabel")
Globals_.Name = "Globals_"
Globals_.Size = UDim2.new(1, 0, 1, 0)
Globals_.BackgroundColor3 = Color3.new(1, 1, 1)
Globals_.BackgroundTransparency = 1
Globals_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Globals_.ZIndex = 5
Globals_.Transparency = 1
Globals_.Text = ""
Globals_.TextColor3 = Color3.new(255, 255, 255)
Globals_.TextSize = 15
Globals_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Globals_.TextXAlignment = Enum.TextXAlignment.Left
Globals_.TextYAlignment = Enum.TextYAlignment.Top
Globals_.Parent = Source

local Strings_ = Instance.new("TextLabel")
Strings_.Name = "Strings_"
Strings_.Size = UDim2.new(1, 0, 1, 0)
Strings_.BackgroundColor3 = Color3.new(1, 1, 1)
Strings_.BackgroundTransparency = 1
Strings_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Strings_.ZIndex = 5
Strings_.Transparency = 1
Strings_.Text = ""
Strings_.TextColor3 = Color3.new(255, 255, 255)
Strings_.TextSize = 15
Strings_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Strings_.TextXAlignment = Enum.TextXAlignment.Left
Strings_.TextYAlignment = Enum.TextYAlignment.Top
Strings_.Parent = Source

local Comments_ = Instance.new("TextLabel")
Comments_.Name = "Comments_"
Comments_.Size = UDim2.new(1, 0, 1, 0)
Comments_.BackgroundColor3 = Color3.new(1, 1, 1)
Comments_.BackgroundTransparency = 1
Comments_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Comments_.ZIndex = 5
Comments_.Transparency = 1
Comments_.Text = ""
Comments_.TextColor3 = Color3.new(255, 255, 255)
Comments_.TextSize = 15
Comments_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Comments_.TextXAlignment = Enum.TextXAlignment.Left
Comments_.TextYAlignment = Enum.TextYAlignment.Top
Comments_.Parent = Source

local Vars_ = Instance.new("TextLabel")
Vars_.Name = "Vars_"
Vars_.Size = UDim2.new(1, 0, 1, 0)
Vars_.BackgroundColor3 = Color3.new(1, 1, 1)
Vars_.BackgroundTransparency = 1
Vars_.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Vars_.ZIndex = 5
Vars_.Transparency = 1
Vars_.Text = ""
Vars_.TextColor3 = Color3.new(255, 255, 255)
Vars_.TextSize = 15
Vars_.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Vars_.TextXAlignment = Enum.TextXAlignment.Left
Vars_.TextYAlignment = Enum.TextYAlignment.Top
Vars_.Parent = Source

local SourceText = Instance.new("StringValue")
SourceText.Name = "SourceText"

SourceText.Parent = TextBox

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = TextBox

local Lines = Instance.new("TextLabel")
Lines.Name = "Lines"
Lines.Position = UDim2.new(0, 0, 0.001, 0)
Lines.Size = UDim2.new(0.0360656, 0, 43.37, 0)
Lines.BackgroundColor3 = Color3.new(1, 1, 1)
Lines.BackgroundTransparency = 1
Lines.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
Lines.ZIndex = 4
Lines.Transparency = 1
Lines.Active = true
Lines.Text = "1"
Lines.TextColor3 = Color3.new(255, 255, 255)
Lines.TextSize = 15
Lines.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Lines.TextYAlignment = Enum.TextYAlignment.Top
Lines.Parent = ScrollingFrame

local ExecuteFromClipBoard = Instance.new("Frame")
ExecuteFromClipBoard.Name = "ExecuteFromClipBoard"
ExecuteFromClipBoard.Position = UDim2.new(0.898239, 0, 0.833333, 0)
ExecuteFromClipBoard.Size = UDim2.new(0, 40, 0, 39)
ExecuteFromClipBoard.BackgroundColor3 = Color3.new(1, 1, 1)
ExecuteFromClipBoard.BackgroundTransparency = 0.8999999761581421
ExecuteFromClipBoard.BorderSizePixel = 0
ExecuteFromClipBoard.BorderColor3 = Color3.new(0, 0, 0)
ExecuteFromClipBoard.Transparency = 0.8999999761581421
ExecuteFromClipBoard.Parent = execframe

local UICorner3 = Instance.new("UICorner")
UICorner3.Name = "UICorner"

UICorner3.Parent = ExecuteFromClipBoard

local ImageButton = Instance.new("ImageButton")
ImageButton.Name = "ImageButton"
ImageButton.Position = UDim2.new(0.266667, 0, 0.25641, 0)
ImageButton.Size = UDim2.new(0, 20, 0, 19)
ImageButton.BackgroundColor3 = Color3.new(1, 1, 1)
ImageButton.BackgroundTransparency = 1
ImageButton.BorderSizePixel = 0
ImageButton.BorderColor3 = Color3.new(0, 0, 0)
ImageButton.Transparency = 1
ImageButton.Image = "rbxassetid://12611463231"
ImageButton.Parent = ExecuteFromClipBoard

local Clear = Instance.new("Frame")
Clear.Name = "Clear"
Clear.Position = UDim2.new(0.806262, 0, 0.833333, 0)
Clear.Size = UDim2.new(0, 40, 0, 39)
Clear.BackgroundColor3 = Color3.new(1, 1, 1)
Clear.BackgroundTransparency = 0.8999999761581421
Clear.BorderSizePixel = 0
Clear.BorderColor3 = Color3.new(0, 0, 0)
Clear.Transparency = 0.8999999761581421
Clear.Parent = execframe

local UICorner4 = Instance.new("UICorner")
UICorner4.Name = "UICorner"

UICorner4.Parent = Clear

local ImageButton2 = Instance.new("ImageButton")
ImageButton2.Name = "ImageButton"
ImageButton2.Position = UDim2.new(0.241667, 0, 0.25641, 0)
ImageButton2.Size = UDim2.new(0, 20, 0, 19)
ImageButton2.BackgroundColor3 = Color3.new(1, 1, 1)
ImageButton2.BackgroundTransparency = 1
ImageButton2.BorderSizePixel = 0
ImageButton2.BorderColor3 = Color3.new(0, 0, 0)
ImageButton2.Transparency = 1
ImageButton2.Image = "rbxassetid://12126161552"
ImageButton2.Parent = Clear

local Execute = Instance.new("Frame")
Execute.Name = "Execute"
Execute.Position = UDim2.new(0.714286, 0, 0.833333, 0)
Execute.Size = UDim2.new(0, 40, 0, 39)
Execute.BackgroundColor3 = Color3.new(1, 1, 1)
Execute.BackgroundTransparency = 0.8999999761581421
Execute.BorderSizePixel = 0
Execute.BorderColor3 = Color3.new(0, 0, 0)
Execute.Transparency = 0.8999999761581421
Execute.Parent = execframe

local UICorner5 = Instance.new("UICorner")
UICorner5.Name = "UICorner"

UICorner5.Parent = Execute

local ImageButton3 = Instance.new("ImageButton")
ImageButton3.Name = "ImageButton"
ImageButton3.Position = UDim2.new(0.241667, 0, 0.25641, 0)
ImageButton3.Size = UDim2.new(0, 20, 0, 19)
ImageButton3.BackgroundColor3 = Color3.new(1, 1, 1)
ImageButton3.BackgroundTransparency = 1
ImageButton3.BorderSizePixel = 0
ImageButton3.BorderColor3 = Color3.new(0, 0, 0)
ImageButton3.Transparency = 1
ImageButton3.Image = "rbxassetid://121060399555299"
ImageButton3.Parent = Execute
ImageButton3.MouseButton1Click:Connect(function()
	loadstring(Source.Text)()
end)
