-- Glenn Heart UI Core
-- Delta Executor | Mobile Friendly

local GlennUI = {}
GlennUI.__index = GlennUI

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlennHeartUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromScale(0.7,0.6)
Main.Position = UDim2.fromScale(0.15,0.2)
Main.BackgroundColor3 = Color3.fromRGB(30,30,30)
Main.Visible = true
Main.Active = true
Main.Draggable = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0,18)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "GLENN UI"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

local Body = Instance.new("Frame", Main)
Body.Position = UDim2.fromScale(0,0.15)
Body.Size = UDim2.fromScale(1,0.85)
Body.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Body)
UIList.Padding = UDim.new(0,8)

-- ======================
-- SECTION
-- ======================
function GlennUI:CreateSection(name)
    local Section = {}

    local Holder = Instance.new("Frame", Body)
    Holder.Size = UDim2.new(1,-12,0,40)
    Holder.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Holder.AutomaticSize = Enum.AutomaticSize.Y

    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,12)

    local Title = Instance.new("TextLabel", Holder)
    Title.Size = UDim2.new(1,0,0,40)
    Title.BackgroundTransparency = 1
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    local List = Instance.new("UIListLayout", Holder)
    List.Padding = UDim.new(0,6)

    -- ======================
    -- TOGGLE
    -- ======================
    function Section:CreateToggle(opt)
        local Toggle = {}
        local State = opt.Default or false

        local Btn = Instance.new("TextButton", Holder)
        Btn.Size = UDim2.new(1,-20,0,36)
        Btn.Text = opt.Name
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)

        local function Refresh()
            Btn.Text = opt.Name.." : "..(State and "ON" or "OFF")
        end
        Refresh()

        Btn.MouseButton1Click:Connect(function()
            State = not State
            Refresh()
            pcall(opt.Callback, State)
        end)

        function Toggle:Set(v)
            State = v
            Refresh()
            pcall(opt.Callback, State)
        end

        function Toggle:Get()
            return State
        end

        return Toggle
    end

    return Section
end

return GlennUI
