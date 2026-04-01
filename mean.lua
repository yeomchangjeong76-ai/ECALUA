--[[
    Daehan Hub v1.7 [Build A Boat For Treasure - Ultra Dirty Edition 2026 FIXED]
    - Insane HK416 Nuclear Kill (80x Spam + Double Headshot + Joint Break + Mega Ragdoll)
    - Silent Infinite Gold (Stronger Value Lock + Smart Remote)
    - Improved Auto Farm (TheEnd GoldenChest + Better Random Delay)
    - Better ESP + Full Water/Terrain Wipe
    - Stronger Anti-AFK + Humanizer
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Loader (UI 안 보이는 문제 방지)
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "DaehanLoader"
loaderGui.ResetOnSpawn = false
loaderGui.Parent = playerGui

local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 380, 0, 220)
loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 16)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0.6, 0)
loadText.Text = "Daehan Hub v1.7 - BABFT Ultra Dirty 2026\n서버 개박살 준비중... 이 병신새끼들아"
loadText.TextColor3 = Color3.fromRGB(255, 40, 40)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 19
loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.9, 0, 0, 12)
barBg.Position = UDim2.new(0.05, 0, 0.75, 0)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Instance.new("UICorner", barFill)

TweenService:Create(barFill, TweenInfo.new(1.0, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.1)
loaderGui:Destroy()

-- Main GUI (UI 안 나오는 문제 완전 해결)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DaehanHubBABFTv17"
mainGui.ResetOnSpawn = false
mainGui.Enabled = true  -- 강제 true
mainGui.Parent = playerGui

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 640, 0, 420)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.78, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "Daehan Hub v1.7 - BABFT Ultra Dirty 2026"
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 45, 0, 45)
closeBtn.Position = UDim2.new(1, -55, 0.5, 0)
closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 30
Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function() mainGui.Enabled = false end)

UserInputService.InputBegan:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.RightControl then
        mainGui.Enabled = not mainGui.Enabled
    end
end)

-- Better Anti-AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
    task.wait(math.random(0.7, 1.8))
    VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
end)

-------------------------------------------------------------------
-- Remotes (더 많이 긁음)
-------------------------------------------------------------------
local remotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        local n = v.Name:lower()
        if n:find("damage") or n:find("hit") or n:find("kill") or n:find("gold") or n:find("coin") or n:find("reward") or n:find("cash") or n:find("give") or n:find("touch") then
            table.insert(remotes, v)
        end
    end
end

-- HK416 Ultra Nuclear Kill (더 세게)
local function GiveHK416()
    local tool = Instance.new("Tool")
    tool.Name = "☢️ HK416 [Mega Nuclear Kill 2026]"
    tool.Parent = player.Backpack

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.6, 1.3, 4.2)
    Instance.new("SpecialMesh", handle).MeshId = "rbxassetid://4701290654"

    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local ray = workspace:Raycast(root.Position, (mouse.Hit.Position - root.Position).Unit * 5000, RaycastParams.new{FilterDescendantsInstances = {player.Character}, FilterType = Enum.RaycastFilterType.Exclude})

        if ray and ray.Instance then
            local model = ray.Instance:FindFirstAncestorWhichIsA("Model")
            if model and model \~= player.Character then
                local hum = model:FindFirstChildOfClass("Humanoid")
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hum and hrp then
                    for i = 1, 80 do  -- 80x spam
                        for _, r in ipairs(remotes) do
                            pcall(function()
                                r:FireServer(hum, 999999999999, "HK416", "Head", Vector3.new(0,0,0))
                            end)
                        end
                        task.wait(math.random(8, 35)/1000)
                    end

                    -- Joint 완전 파괴
                    for _, j in pairs(model:GetDescendants()) do
                        if j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") or j:IsA("BallSocketConstraint") then
                            pcall(function() j:Destroy() end)
                        end
                    end

                    hum.Health = 0
                    hum:ChangeState(Enum.HumanoidStateType.Physics)

                    -- Mega Ragdoll
                    hrp.AssemblyLinearVelocity = Vector3.new(math.random(-500,500), -2000, math.random(-500,500))
                    hrp.AssemblyAngularVelocity = Vector3.new(math.random(1200,2200), math.random(1200,2200), math.random(1200,2200))

                    -- Multiple Explosions
                    for i = 1, 3 do
                        local explosion = Instance.new("Explosion")
                        explosion.Position = hrp.Position + Vector3.new(math.random(-5,5), math.random(0,5), math.random(-5,5))
                        explosion.BlastRadius = 12
                        explosion.Parent = workspace
                        task.wait(0.1)
                    end

                    print("Daehan v1.7 - MEGA Nuclear Kill on " .. (model.Name or "some bitch"))
                end
            end
        end
    end)
end

-- Silent Infinite Gold (더 강력)
local function EnableInfiniteGold()
    local dataFolder = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data") or player:WaitForChild("Data", 3)
    if dataFolder then
        for _, v in pairs(dataFolder:GetDescendants()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then
                local n = v.Name:lower()
                if n:find("gold") or n:find("coin") or n:find("money") or n:find("cash") then
                    v.Value = 999999999999
                    v.Changed:Connect(function() v.Value = 999999999999 end)
                end
            end
        end
    end

    task.spawn(function()
        while task.wait(math.random(6, 14)) do
            for _, r in ipairs(remotes) do
                if r.Name:lower():find("gold") or r.Name:lower():find("coin") or r.Name:lower():find("reward") then
                    pcall(function() r:FireServer(99999999999) end)
                end
            end
        end
    end)

    print("Daehan v1.7 - Silent Infinite Gold ON (더 세게)")
end

-- Auto Farm
local farming = false
local function ToggleAutoFarm()
    farming
