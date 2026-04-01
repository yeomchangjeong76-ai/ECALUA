--[[
    Daehan Hub v1.5 [Build A Boat For Treasure - Ultra Dirty Edition 2026]
    - Stronger Real Kill HK416 (Massive Ragdoll + Joint Break + Insane Push)
    - Better Infinite Gold (Multi Remote Spam + Value Lock)
    - Improved Auto Farm GoldenChest (TheEnd Loop + Stable TP)
    - Clean ESP + Water/Terrain Full Remove
    - Anti-AFK + Extra Dirty Features
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

-- Loader (더 빠르게)
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "DaehanLoader"
loaderGui.ResetOnSpawn = false
loaderGui.Parent = playerGui

local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 340, 0, 190)
loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 16)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0.65, 0)
loadText.Text = "Daehan Hub v1.5 - BABFT Ultra Dirty 2026\n로딩 개같이 빠르게..."
loadText.TextColor3 = Color3.fromRGB(0, 255, 80)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 19
loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.88, 0, 0, 9)
barBg.Position = UDim2.new(0.06, 0, 0.78, 0)
barBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
Instance.new("UICorner", barFill)

TweenService:Create(barFill, TweenInfo.new(0.9, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.1)
loaderGui:Destroy()

-- Main GUI (조금 더 예쁘게)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DaehanHubBABFTv15"
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 42)
topBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.75, 0, 1, 0)
title.Position = UDim2.new(0, 18, 0, 0)
title.Text = "Daehan Hub v1.5 - BABFT Ultra Dirty 2026"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 38, 0, 38)
closeBtn.Position = UDim2.new(1, -45, 0.5, 0)
closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 26
Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function() mainGui.Enabled = false end)

UserInputService.InputBegan:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.RightControl then
        mainGui.Enabled = not mainGui.Enabled
    end
end)

-- Anti-AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-------------------------------------------------------------------
-- Remotes (더 똑똑하게 찾기)
-------------------------------------------------------------------
local function GetRemotes()
    local rems = {}
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local n = v.Name:lower()
            if n:find("damage") or n:find("hit") or n:find("kill") or n:find("gold") or n:find("coin") or n:find("reward") or n:find("give") or n:find("cash") then
                table.insert(rems, v)
            end
        end
    end
    return rems
end

local remotes = GetRemotes()

-- HK416 Ultra Real Kill (더 세게)
local function GiveHK416()
    local tool = Instance.new("Tool")
    tool.Name = "🔥 HK416 [Ultra Ragdoll Kill 2026]"
    tool.Parent = player.Backpack

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.6, 1.3, 4.2)
    Instance.new("SpecialMesh", handle).MeshId = "rbxassetid://4701290654"

    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local ray = workspace:Raycast(root.Position, (mouse.Hit.Position - root.Position).Unit * 3000, RaycastParams.new{FilterDescendantsInstances = {player.Character}, FilterType = Enum.RaycastFilterType.Exclude})

        if ray and ray.Instance then
            local model = ray.Instance:FindFirstAncestorWhichIsA("Model")
            if model and model \~= player.Character then
                local hum = model:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Massive Remote Spam
                    for i = 1, 25 do
                        for _, r in ipairs(remotes) do
                            pcall(function() 
                                r:FireServer(hum, 999999999, "HK416", "Head", Vector3.new(0,0,0)) 
                            end)
                        end
                        task.wait(0.03)
                    end

                    -- Joint + Weld Destruction
                    for _, j in pairs(model:GetDescendants()) do
                        if j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") or j:IsA("BallSocketConstraint") or j:IsA("NoCollisionConstraint") then
                            pcall(function() j:Destroy() end)
                        end
                    end

                    hum.Health = 0
                    hum:ChangeState(Enum.HumanoidStateType.Physics)

                    local hrp = model:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.AssemblyLinearVelocity = Vector3.new(math.random(-200,200), -800, math.random(-200,200))
                        hrp.AssemblyAngularVelocity = Vector3.new(math.random(600,1200), math.random(600,1200), math.random(600,1200))
                    end

                    print("Daehan - Ultra Kill on ".. (model.Name or "someone"))
                end
            end
        end
    end)
end

-- Infinite Gold (더 더럽게)
local function EnableInfiniteGold()
    local data = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data") or player:WaitForChild("Data", 5)
    if not data then return end

    local function LockValue(v)
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            v.Value = 9999999999
            v.Changed:Connect(function() v.Value = 9999999999 end)
        end
    end

    for _, v in pairs(data:GetDescendants()) do
        if v.Name:lower():find("gold") or v.Name:lower():find("coin") or v.Name:lower():find("money") or v.Name:lower():find("cash") then
            LockValue(v)
        end
    end

    -- Remote spam loop
    task.spawn(function()
        while task.wait(0.15) do
            for _, r in ipairs(remotes) do
                if r.Name:lower():find("gold") or r.Name:lower():find("coin") or r.Name:lower():find("reward") then
                    pcall(function() r:FireServer(999999999) end)
                end
            end
        end
    end)

    print("Daehan v1.5 - Infinite Gold ON (Ultra Dirty)")
end

-- Auto Farm (더 안정적)
local farming = false
local function ToggleAutoFarm()
    farming = not farming
    print("Auto Farm:", farming)

    task.spawn(function()
        while farming and task.wait(0.65) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local stages = workspace:FindFirstChild("BoatStages") or workspace:FindFirstChild("Stages")
                if stages then
                    local normal = stages:FindFirstChild("NormalStages") or stages
                    local theEnd = normal:FindFirstChild("TheEnd") or normal:FindFirstChild("End")
                    if theEnd then
                        local chest = theEnd:FindFirstChild("GoldenChest") or theEnd:FindFirstChild("Chest")
                        if chest and chest:FindFirstChild("Trigger") or chest:FindFirstChild("TouchInterest") then
                            local trigger = chest:FindFirstChild("Trigger") or chest
                            hrp.CFrame = trigger.CFrame * CFrame.new(0, 6, 0)
                            task.wait(0.25)
                            pcall(function() firetouchinterest(hrp, trigger, 0) end)
                            task.wait(0.08)
                            pcall(function() firetouchinterest(hrp, trigger, 1) end)
                        end
                    end
                end
            end
        end
    end)
end

-- ESP (조금 더 좋게)
local espEnabled = false
local function ToggleESP()
    espEnabled = not espEnabled
    print("ESP:", espEnabled)

    -- 기존 ESP 제거
    for _, plr in pairs(Players:GetPlayers()) do
        if plr \~= player and plr.Character and plr.Character:FindFirstChild("Head") then
            if plr.Character.Head:FindFirstChild("DaehanESP") then
                plr.Character.Head.DaehanESP:Destroy()
            end
        end
    end

    if not espEnabled then return end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr \~= player then
            local function createESP(char)
                task.wait(0.8)
                local head = char:WaitForChild("Head", 5)
                if not head then return end

                local bg = Instance.new("BillboardGui")
                bg.Name = "DaehanESP"
                bg.Size = UDim2.new(0, 220, 0, 60)
                bg.AlwaysOnTop = true
                bg.LightInfluence = 0
                bg.Parent = head

                local txt = Instance.new("TextLabel", bg)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(0, 255, 110)
                txt.Font = Enum.Font.GothamBold
                txt.TextSize = 15
                txt.TextStrokeTransparency = 0.6

                RunService.RenderStepped:Connect(function()
                    if not espEnabled or not bg.Parent then return end
                    local myHead = player.Character and player.Character:FindFirstChild("Head")
                    local hisHead = char:FindFirstChild("Head")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if myHead and hisHead then
                        local dist = math.floor((myHead.Position - hisHead.Position).Magnitude)
                        local health = hum and math.floor(hum.Health) or "?"
                        txt.Text = plr.DisplayName .. " | " .. dist .. "m | HP:" .. health
                        if dist < 40 then 
                            txt.TextColor3 = Color3.fromRGB(255, 50, 50) 
                        end
                    end
                end)
            end

            if plr.Character then createESP(plr.Character) end
            plr.CharacterAdded:Connect(createESP)
        end
    end
end

-- Water & Terrain Remove
local function RemoveWater()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("water") or v.Name:lower():find("ocean") or v:IsA("Terrain") or v:IsA("Part") and v.Transparency > 0.5 and v.Size.Y < 10 then
            pcall(function() v:Destroy() end)
        end
    end
    print("Daehan - All Water & Terrain Removed (server looks like shit now)")
end

-------------------------------------------------------------------
-- Buttons
-------------------------------------------------------------------
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 180, 1, -42)
sidebar.Position = UDim2.new(0, 0, 0, 42)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)

local function MakeBtn(txt, posY, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 45)
    btn.Position = UDim2.new(0.04, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 15
    Instance.new("UICorner", btn)
    btn.Parent = sidebar
    btn.MouseButton1Click:Connect(func)
end

MakeBtn("Give HK416 [Ultra Kill]", 15, GiveHK416)
MakeBtn("Infinite Gold (Dirty)", 70, EnableInfiniteGold)
MakeBtn("Toggle Auto Farm", 125, ToggleAutoFarm)
MakeBtn("Toggle ESP", 180, ToggleESP)
MakeBtn("Remove All Water", 235, RemoveWater)

print("Daehan Hub v1.5 Ultra Dirty Edition Loaded - Fuck the servers harder 2026")
