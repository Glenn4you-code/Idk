-- Glenn4you UI Library (MOBILE + PC FIX)

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Library = {}

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Parent = game.CoreGui
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false

-- SHADOW
local Shadow = Instance.new("Frame", Gui)
Shadow.Size = UDim2.fromOffset(330,270)
Shadow.Position = UDim2.fromScale(0.5,0.5)
Shadow.AnchorPoint = Vector2.new(0.5,0.5)
Shadow.BackgroundColor3 = Color3.new(0,0,0)
Shadow.BackgroundTransparency = 0.4
Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0,22)

-- MAIN
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(320,260)
Main.Position = Shadow.Position
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(22,22,25)
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,20)

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,-40,0,36)
Title.Position = UDim2.new(0,12,0,8)
Title.BackgroundTransparency = 1
Title.Text = "UI"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.new(1,1,1)
Title.TextXAlignment = Left

-- CLOSE
local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.fromOffset(24,24)
Close.Position = UDim2.new(1,-30,0,10)
Close.Text = "✕"
Close.BackgroundColor3 = Color3.fromRGB(40,40,45)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

-- CONTENT
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,12,0,52)
Content.Size = UDim2.new(1,-24,1,-64)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0,10)

-- DRAG (PC + MOBILE)
do
	local drag, startPos, startInput
	Title.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = true
			startInput = i.Position
			startPos = Main.Position
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - startInput
			Main.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
			Shadow.Position = Main.Position
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			drag = false
		end
	end)
end

-- API
function Library:CreateJudul(t)
	Title.Text = "Glenn4you | "..t
end

function Library:Toggle(text, cb)
	local Row = Instance.new("TextButton", Content)
	Row.Size = UDim2.new(1,0,0,32)
	Row.Text = ""
	Row.BackgroundColor3 = Color3.fromRGB(35,35,40)
	Instance.new("UICorner", Row).CornerRadius = UDim.new(0,8)

	local Label = Instance.new("TextLabel", Row)
	Label.Size = UDim2.new(1,-50,1,0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 14
	Label.TextColor3 = Color3.new(1,1,1)
	Label.TextXAlignment = Left

	local on = false
	Row.MouseButton1Click:Connect(function()
		on = not on
		Row.BackgroundColor3 = on and Color3.fromRGB(255,70,70) or Color3.fromRGB(35,35,40)
		if cb then cb(on) end
	end)
end

function Library:Button(text, btnText, cb)
	local Row = Instance.new("TextButton", Content)
	Row.Size = UDim2.new(1,0,0,32)
	Row.Text = text.."   ["..btnText.."]"
	Row.Font = Enum.Font.Gotham
	Row.TextSize = 14
	Row.TextColor3 = Color3.new(1,1,1)
	Row.BackgroundColor3 = Color3.fromRGB(40,40,45)
	Instance.new("UICorner", Row).CornerRadius = UDim.new(0,8)

	Row.MouseButton1Click:Connect(function()
		if cb then cb() end
	end)
end

function Library:Dropdown(text, list, cb)
	local open = false

	local Row = Instance.new("TextButton", Content)
	Row.Size = UDim2.new(1,0,0,32)
	Row.Text = text
	Row.BackgroundColor3 = Color3.fromRGB(40,40,45)
	Instance.new("UICorner", Row).CornerRadius = UDim.new(0,8)

	local Drop = Instance.new("Frame", Content)
	Drop.Size = UDim2.new(1,0,0,0)
	Drop.ClipsDescendants = true
	Drop.BackgroundTransparency = 1

	local DLayout = Instance.new("UIListLayout", Drop)

	for _,v in ipairs(list) do
		local Opt = Instance.new("TextButton", Drop)
		Opt.Size = UDim2.new(1,0,0,28)
		Opt.Text = v
		Opt.BackgroundColor3 = Color3.fromRGB(30,30,35)
		Opt.TextColor3 = Color3.new(1,1,1)

		Opt.MouseButton1Click:Connect(function()
			cb(v)
			open = false
			TweenService:Create(Drop,TweenInfo.new(0.2),{Size=UDim2.new(1,0,0,0)}):Play()
		end)
	end

	Row.MouseButton1Click:Connect(function()
		open = not open
		TweenService:Create(Drop,TweenInfo.new(0.2),{
			Size = open and UDim2.new(1,0,0,#list*28) or UDim2.new(1,0,0,0)
		}):Play()
	end)
end

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
	Shadow.Visible = false
end)

return Library
