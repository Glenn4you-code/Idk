-- Glenn4You | Premium Clean UI (Animated Gradient Edition)
-- Delta Executor | Mobile Friendly

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local GlennAPI = {}
local AutoY = 80

-- ================= THEME =================
local Theme = {
    TitleFont = Enum.Font.GothamBold,
    MainFont  = Enum.Font.GothamSemibold,
    TextFont  = Enum.Font.GothamMedium,

    White = Color3.fromRGB(255,255,255),
    SoftWhite = Color3.fromRGB(235,235,235),
    Gray = Color3.fromRGB(185,185,185),

    Dark = Color3.fromRGB(14,14,14),
    Card = Color3.fromRGB(26,26,26),

    Red = Color3.fromRGB(255,95,95),
    Black = Color3.fromRGB(15,15,15)
}

-- ================= GUI =================
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- ================= MAIN =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,330,0,280)
main.Position = UDim2.new(0.5,-165,0.5,-140)
main.BackgroundColor3 = Theme.Card
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

local glow = Instance.new("UIStroke", main)
glow.Thickness = 1.5
glow.Color = Theme.Red
glow.Transparency = 0.55

-- ================= HEADER =================
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,58)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Position = UDim2.new(0,20,0,14)
title.Size = UDim2.new(1,-80,0,20)
title.Text = "Glenn4You"
title.Font = Theme.TitleFont
title.TextSize = 16
title.TextColor3 = Theme.White
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local titleGrad = Instance.new("UIGradient", title)
titleGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Red),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,120,120)),
    ColorSequenceKeypoint.new(1, Theme.Black)
}

local titleStroke = Instance.new("UIStroke", title)
titleStroke.Color = Theme.Red
titleStroke.Transparency = 0.6
titleStroke.Thickness = 0.8

local subtitle = Instance.new("TextLabel", header)
subtitle.Position = UDim2.new(0,20,0,36)
subtitle.Size = UDim2.new(1,-80,0,14)
subtitle.Text = "Premium Clean Control"
subtitle.Font = Theme.TextFont
subtitle.TextSize = 11
subtitle.TextColor3 = Theme.Gray
subtitle.BackgroundTransparency = 1
subtitle.TextXAlignment = Enum.TextXAlignment.Left

function GlennAPI:SetTitle(t) title.Text=t end
function GlennAPI:SetSubtitle(t) subtitle.Text=t end

-- ================= LINE =================
local line = Instance.new("Frame", main)
line.Size = UDim2.new(1,-40,0,2)
line.Position = UDim2.new(0,20,0,58)
line.BorderSizePixel = 0
Instance.new("UICorner", line).CornerRadius = UDim.new(1,0)

local lineGrad = Instance.new("UIGradient", line)
lineGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Black),
    ColorSequenceKeypoint.new(0.5, Theme.Red),
    ColorSequenceKeypoint.new(1, Theme.Black)
}

-- ================= CLOSE =================
local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,28,0,28)
close.Position = UDim2.new(1,-38,0,15)
close.Text = "×"
close.Font = Theme.MainFont
close.TextSize = 14
close.TextColor3 = Theme.SoftWhite
close.BackgroundColor3 = Color3.fromRGB(35,35,35)
close.AutoButtonColor = false
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

-- ================= API TOGGLE =================
function GlennAPI:CreateToggle(opt)
    local text = opt.Name
    local y = AutoY
    AutoY += 45

    local row = Instance.new("Frame", main)
    row.Size = UDim2.new(1,-40,0,44)
    row.Position = UDim2.new(0,20,0,y)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1,-70,1,0)
    label.Text = text
    label.Font = Theme.MainFont
    label.TextSize = 14
    label.TextColor3 = Theme.White
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", row)
    toggle.Size = UDim2.new(0,44,0,22)
    toggle.Position = UDim2.new(1,-44,0.5,-11)
    toggle.Text = ""
    toggle.BackgroundColor3 = Color3.fromRGB(45,45,45)
    toggle.AutoButtonColor = false
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

    local dot = Instance.new("Frame", toggle)
    dot.Size = UDim2.new(0,16,0,16)
    dot.Position = UDim2.new(0,3,0.5,-8)
    dot.BackgroundColor3 = Theme.Gray
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

    local State = opt.Default or false
    local function refresh()
        toggle.BackgroundColor3 = State and Theme.Red or Color3.fromRGB(45,45,45)
        dot.Position = State and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)
        dot.BackgroundColor3 = State and Theme.White or Theme.Gray
    end
    refresh()

    toggle.MouseButton1Click:Connect(function()
        State = not State
        refresh()
        pcall(opt.Callback, State)
    end)

    return {Set=function(_,v) State=v refresh() end, Get=function() return State end}
end

-- ================= API DROPDOWN =================
function GlennAPI:CreateDropdown(opt)
    local options = opt.Options
    local Value = opt.Default or options[1]
    local y = AutoY
    AutoY += 45

    local row = Instance.new("Frame", main)
    row.Size = UDim2.new(1,-40,0,44)
    row.Position = UDim2.new(0,20,0,y)
    row.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1,-110,1,0)
    label.Text = opt.Name
    label.Font = Theme.MainFont
    label.TextSize = 14
    label.TextColor3 = Theme.White
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextButton", row)
    box.Size = UDim2.new(0,90,0,24)
    box.Position = UDim2.new(1,-90,0.5,-12)
    box.Text = Value
    box.Font = Theme.TextFont
    box.TextSize = 13
    box.TextColor3 = Theme.White
    box.BackgroundColor3 = Color3.fromRGB(35,35,35)
    box.AutoButtonColor = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

    local list = Instance.new("Frame", main)
    list.Size = UDim2.new(0,90,0,0)
    list.Position = UDim2.new(box.Position.X.Scale, box.Position.X.Offset + 20, row.Position.Y.Scale, row.Position.Y.Offset + 44)
    list.BackgroundColor3 = Color3.fromRGB(30,30,30)
    list.BorderSizePixel = 0
    list.ClipsDescendants = true
    list.ZIndex = 10
    Instance.new("UICorner", list).CornerRadius = UDim.new(0,8)

    local open=false
    for i,v in ipairs(options) do
        local b=Instance.new("TextButton",list)
        b.Size=UDim2.new(1,0,0,30)
        b.Position=UDim2.new(0,0,0,(i-1)*30)
        b.Text=v
        b.Font=Theme.TextFont
        b.TextSize=13
        b.TextColor3=Theme.White
        b.BackgroundTransparency=1
        b.ZIndex=11
        b.MouseButton1Click:Connect(function()
            Value=v
            box.Text=v
            pcall(opt.Callback,v)
            open=false
            TweenService:Create(list,TweenInfo.new(0.15),{Size=UDim2.new(0,90,0,0)}):Play()
        end)
    end

    box.MouseButton1Click:Connect(function()
        open=not open
        TweenService:Create(list,TweenInfo.new(0.15),{Size=open and UDim2.new(0,90,0,#options*30) or UDim2.new(0,90,0,0)}):Play()
    end)

    return {Get=function() return Value end, Set=function(_,v) Value=v box.Text=v end}
end

-- ================= DRAG =================
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging then
        local d = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
main.InputEnded:Connect(function() dragging = false end)

-- ================= OPEN BUTTON =================
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,38,0,38)
openBtn.Position = UDim2.new(0,20,0.5,-19)
openBtn.Text = "G"
openBtn.Font = Theme.TitleFont
openBtn.TextSize = 15
openBtn.TextColor3 = Theme.White
openBtn.BackgroundColor3 = Theme.Card
openBtn.Visible = false
openBtn.Active = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1,0)

local stroke2 = Instance.new("UIStroke", openBtn)
stroke2.Color = Theme.Red
stroke2.Thickness = 1
stroke2.Transparency = 0.5

close.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)
openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

return GlennAPI
