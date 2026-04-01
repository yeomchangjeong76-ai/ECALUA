--[[
    Daehan Hub v1.4 [Build A Boat For Treasure - Dirty Edition]
    - Real Kill HK416 (Joint + Ragdoll + Strong Push)
    - Infinite Gold (Value Lock + Remote Spam)
    - Auto Farm GoldenChest (TheEnd 반복)
    - Clean ESP + Water Remove
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-------------------------------------------------------------------
-- Loader (빠르게)
-------------------------------------------------------------------
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "DaehanLoader"
loaderGui.ResetOnSpawn = false
loaderGui.Parent = playerGui

local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 320, 0, 180)
loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 16)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0.6, 0)
loadText.Text = "Daehan Hub v1.4 - BABFT Dirty Edition\n로딩중..."
loadText.TextColor3 = Color3.fromRGB(0, 255, 100)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 18
loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.85, 0, 0, 8)
barBg.Position = UDim2.new(0.075, 0, 0.8, 0)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
Instance.new("UICorner", barFill)

TweenService:Create(barFill, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.4)
loaderGui:Destroy()

-------------------------------------------------------------------
-- Main GUI
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DaehanHubBABFT"
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 580, 0, 360)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "Daehan Hub v1.4 - Build A Boat Dirty"
title.TextColor3 = Color3.fromRGB(0, 255, 120)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0.5, 0)
closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function() mainGui.Enabled = false end)

UserInputService.InputBegan:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.RightControl then
        mainGui.Enabled = not mainGui.Enabled
    end
end)

-------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------
local function GetRemotes()
    local rems = {}
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local n = v.Name:lower()
            if n:find("damage") or n:find("hit") or n:find("kill") or n:find("gold") or n:find("coin") or n:find("reward") then
                table.insert(rems, v)
            end
        end
    end
    return rems
end

local remotes = GetRemotes()

-- HK416 Real Kill (더 세게)
local function GiveHK416()
    local tool = Instance.new("Tool")
    tool.Name = "🔥 HK416 [Real Ragdoll Kill]"
    tool.Parent = player.Backpack

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.6, 1.2, 4)
    Instance.new("SpecialMesh", handle).MeshId = "rbxassetid://4701290654"

    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local ray = workspace:Raycast(root.Position, (mouse.Hit.Position - root.Position).Unit * 2000, RaycastParams.new{FilterDescendantsInstances = {player.Character}, FilterType = Enum.RaycastFilterType.Exclude})

        if ray and ray.Instance then
            local model = ray.Instance:FindFirstAncestorWhichIsA("Model")
            if model and model \~= player.Character then
                local hum = model:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Remote spam
                    for _, r in ipairs(remotes) do
                        pcall(function() r:FireServer(hum, 999999, "HK416", "Head") end)
                    end

                    -- Joint Destruction
                    for _, j in pairs(model:GetDescendants()) do
                        if j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") or j:IsA("BallSocketConstraint") then
                            pcall(function() j:Destroy() end)
                        end
                    end

                    hum.Health = 0
                    hum:ChangeState(Enum.HumanoidStateType.Physics)

                    local hrp = model:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.AssemblyLinearVelocity = Vector3.new(math.random(-100,100), -500, math.random(-100,100))
                        hrp.AssemblyAngularVelocity = Vector3.new(math.random(300,800), math.random(300,800), math.random(300,800))
                    end
                end
            end
        end
    end)
end

-- Infinite Gold
local function EnableInfiniteGold()
    local data = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data")
    if not data then data = player:WaitForChild("Data", 3) end

    local function LockValue(v)
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            v.Value = 999999999
            v.Changed:Connect(function() v.Value = 999999999 end)
        end
    end

    for _, v in pairs(data:GetDescendants()) do
        if v.Name:lower():find("gold") or v.Name:lower():find("coin") or v.Name:lower():find("money") then
            LockValue(v)
        end
    end

    -- Remote spam
    for _, r in ipairs(remotes) do
        if r.Name:lower():find("gold") or r.Name:lower():find("coin") then
            task.spawn(function()
                for i = 1, 30 do
                    pcall(function() r:FireServer(99999999) end)
                    task.wait(0.1)
                end
            end)
        end
    end
