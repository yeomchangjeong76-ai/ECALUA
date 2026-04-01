--[[
    Daehan Hub v1.6 [Build A Boat For Treasure - Ultra Dirty Edition 2026]
    - Insane HK416 Real Kill (50x Spam + Headshot Force + Joint Break + Nuclear Ragdoll)
    - Silent Infinite Gold (Value Lock + Smart Remote)
    - Improved Auto Farm (TheEnd GoldenChest + Random Delay)
    - Better ESP + Full Water/Terrain Wipe
    - Stronger Anti-AFK + Random Humanizer
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

-- Loader
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "DaehanLoader"
loaderGui.ResetOnSpawn = false
loaderGui.Parent = playerGui

local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 360, 0, 200)
loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 16)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0.65, 0)
loadText.Text = "Daehan Hub v1.6 - BABFT Ultra Dirty 2026\n서버 개박살 준비중... 이 병신새끼들아"
loadText.TextColor3 = Color3.fromRGB(255, 50, 50)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 18
loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.9, 0, 0, 10)
barBg.Position = UDim2.new(0.05, 0, 0.78, 0)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", barBg)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
Instance.new("UICorner", barFill)

TweenService:Create(barFill, TweenInfo.new(1.2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.3)
loaderGui:Destroy()

-- Main GUI
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DaehanHubBABFTv16"
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 620, 0, 400)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.78, 0, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "Daehan Hub v1.6 - BABFT Ultra Dirty 2026"
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0.5, 0)
closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 28
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
    task.wait(math.random(0.8, 1.5))
    VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
end)

-------------------------------------------------------------------
-- Remotes (조금 더 똑똑하게)
-------------------------------------------------------------------
local remotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        local n = v.Name:lower()
        if n:find("damage") or n:find("hit") or n:find("kill") or n:find("gold") or n:find("coin") or n:find("reward") or n:find("cash") or n:find("give") then
            table.insert(remotes, v)
        end
    end
end

-- HK416 Ultra Nuclear Kill (더 세게 업글)
local function GiveHK416()
    local tool = Instance.new("Tool")
    tool.Name = "☢️ HK416 [Nuclear Ragdoll Kill 2026]"
    tool.Parent = player.Backpack

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.6, 1.3, 4.2)
    Instance.new("SpecialMesh", handle).MeshId = "rbxassetid://4701290654"

    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local ray = workspace:Raycast(root.Position, (mouse.Hit.Position - root.Position).Unit * 4000, RaycastParams.new{FilterDescendantsInstances = {player.Character}, FilterType = Enum.RaycastFilterType.Exclude})

        if ray and ray.Instance then
            local model = ray.Instance:FindFirstAncestorWhichIsA("Model")
            if model and model \~= player.Character then
                local hum = model:FindFirstChildOfClass("Humanoid")
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hum and hrp then

                    -- Headshot Force + Massive Spam (random delay로 약간 humanize)
                    for i = 1, 50 do
                        for _, r in ipairs(remotes) do
                            pcall(function()
                                r:FireServer(hum, 9999999999, "HK416", "Head", Vector3.new(0,0,0))
                            end)
                        end
                        task.wait(math.random(15, 40)/1000)  -- 0.015 \~ 0.04초 랜덤
                    end

                    -- Joint & Weld 완전 파괴
                    for _, j in pairs(model:GetDescendants()) do
                        if j:IsA("Motor6D") or j:IsA("Weld") or j:IsA("WeldConstraint") or j:IsA("BallSocketConstraint") or j:IsA("NoCollisionConstraint") then
                            pcall(function() j:Destroy() end)
                        end
                    end

                    hum.Health = 0
                    hum:ChangeState(Enum.HumanoidStateType.Physics)

                    -- 미친 Nuclear Ragdoll
                    hrp.AssemblyLinearVelocity = Vector3.new(math.random(-300,300), -1200, math.random(-300,300))
                    hrp.AssemblyAngularVelocity = Vector3.new(math.random(800,1600), math.random(800,1600), math.random(800,1600))

                    -- Explosion 느낌 추가 (시각적)
                    local explosion = Instance.new("Explosion")
                    explosion.Position = hrp.Position
                    explosion.BlastRadius = 8
                    explosion.Parent = workspace

                    print("Daehan v1.6 - Nuclear Kill on " .. (model.Name or "some bitch"))
                end
            end
        end
    end)
end

-- Silent Infinite Gold (더 조용하게)
local function EnableInfiniteGold()
    local dataFolder = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data") or player:WaitForChild("Data", 5)
    if not dataFolder then return end

    for _, v in pairs(dataFolder:GetDescendants()) do
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            local n = v.Name:lower()
            if n:find("gold") or n:find("coin") or n:find("money") or n:find("cash") then
                v.Value = 99999999999
                v.Changed:Connect(function() v.Value = 99999999999 end)
            end
        end
    end

    -- Smart remote spam (너무 자주 안 함)
    task.spawn(function()
        while task.wait(math.random(8, 15)) do
            for _, r in ipairs(remotes) do
                if r.Name:lower():find("gold") or r.Name:lower():find("coin") or r.Name:lower():find("reward") then
                    pcall(function() r:FireServer(999999999) end)
                end
            end
        end
    end)

    print("Daehan v1.6 - Silent Infinite Gold ON")
end

-- Auto Farm (random delay 추가)
local farming = false
local function ToggleAutoFarm()
    farming = not farming
    print("Auto Farm:", farming)

    task.spawn(function()
        while farming and task.wait(0.7) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local stages = workspace:FindFirstChild("BoatStages") or workspace:FindFirstChild("Stages")
                if stages then
                    local normal = stages:FindFirstChild("NormalStages") or stages
                    local theEnd = normal:FindFirstChild("TheEnd") or normal:FindFirstChild("End")
                    if theEnd then
                        local chest = theEnd:FindFirstChild("GoldenChest") or theEnd:FindFirstChild("Chest")
                        if chest then
                            local trigger = chest:FindFirstChild("Trigger") or chest
                            if trigger then
                                hrp.CFrame = trigger.CFrame * CFrame.new(0, 5.5, 0)
                                task.wait(math.random(18, 28)/100)
                                pcall(function() firetouchinterest(hrp, trigger, 0) end)
                                task.wait(math.random(6, 12)/100)
                                pcall(function() firetouchinterest(hrp, trigger, 1) end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- ESP (기존 + 살짝 업글)
local espEnabled = false
local function ToggleESP()
    espEnabled = not espEnabled
    print("ESP:", espEnabled)

    -- 기존 제거
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
                task.wait(0.6)
                local head = char:WaitForChild("Head", 5)
                if not head then return end

                local bg = Instance.new("BillboardGui")
                bg.Name = "DaehanESP"
                bg.Size = UDim2.new(0, 240, 0, 65)
                bg.AlwaysOnTop = true
                bg.LightInfluence = 0
                bg.Parent = head

                local txt = Instance.new("TextLabel", bg)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(0, 255, 100)
                txt.Font = Enum.Font.GothamBold
                txt.TextSize = 16
                txt.TextStrokeTransparency = 0.5

                RunService.RenderStepped:Connect(function()
                    if not espEnabled or not bg.Parent then return end
                    local myHead = player.Character and player.Character:FindFirstChild("Head")
                    local hisHead = char:FindFirstChild("Head")
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if myHead and hisHead then
                        local dist = math.floor((myHead.Position - hisHead.Position).Magnitude)
                        local health = hum and math.floor(hum.Health) or "?"
                        txt.Text = plr.DisplayName .. " | " .. dist .. "m | HP: " .. health
                        if dist < 35 then 
                            txt.TextColor3 = Color3.fromRGB(255, 40, 40) 
                        end
                    end
                end)
            end

            if plr.Character then createESP(plr.Character) end
            plr.CharacterAdded:Connect(createESP)
        end
    end
end

-- Water & Terrain Remove (더 철저하게)
local function RemoveWater()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("water") or v.Name:lower():find("ocean") or v:IsA("Terrain") or (v:IsA("Part") and (v.Transparency > 0.4 or v.Size.Y < 12)) then
            pcall(function() v:Destroy() end)
        end
    end
    print("Daehan v1.6 - Water & Terrain Completely Wiped (서버 이제 지옥임)")
end

-------------------------------------------------------------------
-- Buttons
-------------------------------------------------------------------
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 190, 1, -45)
sidebar.Position = UDim2.new(0, 0, 0, 45)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)

local function MakeBtn(txt, posY, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 48)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 15
    Instance.new("UICorner", btn)
    btn.Parent = sidebar
    btn.MouseButton1Click:Connect(func)
end

MakeBtn("☢️ Give HK416 [Nuclear Kill]", 20, GiveHK416)
MakeBtn("💰 Infinite Gold (Silent)", 80, EnableInfiniteGold)
MakeBtn("🌟 Toggle Auto Farm", 140, ToggleAutoFarm)
MakeBtn("👁️ Toggle ESP", 200, ToggleESP)
MakeBtn("🌊 Remove All Water", 260, RemoveWater)

print("Daehan Hub v1.6 Ultra Dirty Loaded - 이제 서버를 더럽게 박살내자 이 병신새끼들아")
